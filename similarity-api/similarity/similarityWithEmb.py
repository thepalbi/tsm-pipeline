import hashlib
import os
import torch
import json
from sklearn.metrics.pairwise import cosine_similarity
from .location import Location


def createReprDict(predictions):
    """
    Creates a dictionary repr -> [loc, stmLoc, funcLoc] out of the prediction json in memory.
    """
    reprDict = dict()
    for elem in predictions:
        loc = elem["location"]
        repr = elem["repr"]
        path = loc["path"]
        project = loc["projectName"]
        location = Location(project, path,
                            loc["startLine"], loc["startColumn"],
                            loc["endLine"], loc["endColumn"])
        # the enclosing stm
        locStm = elem["locationEnclosingStm"]
        locationStm = Location(project, path,
                               locStm["startLine"], locStm["startColumn"],
                               locStm["endLine"], locStm["endColumn"])
        # the enclosing function
        locFunc = elem["locationEnclosingFunc"]
        locationFunc = Location(project, path,
                                locFunc["startLine"], locFunc["startColumn"],
                                locFunc["endLine"], locFunc["endColumn"])
        if repr not in reprDict.keys():
            reprDict[repr] = list()
        reprDict[repr].append((location,  locationStm, locationFunc))
    return reprDict


def readJsonPredictions(fileName):
    """
    Creates a dictionary repr -> [loc, stmLoc, funcLoc] out of the prediction json file.
    """
    with open(fileName, encoding="utf-8") as predictionsFile:
        source = predictionsFile.read()
        if source.strip() == "":
            return dict()
        data = json.loads(source)
        dictPredRepr = createReprDict(data)
        return dictPredRepr


def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


class EmbeddingsReader:
    def __init__(self, predictionsFile, embeddingsFolder, chunk_size, threshold=0.92):
        self.embeddingsFolder = embeddingsFolder
        self.chunk_size = chunk_size
        self.dictPredRepr = readJsonPredictions(predictionsFile)
        self.threshold = threshold

    def loadKnownSinkEmbForRepPage(self, repr, prefix, page):
        """
        Reads the embeddings for a repr. Since the embeddings are organized by chunks
        we concatenate the chunks into a single tensor.
        In case of memory issues, we may need to read only a part of the embeddings.
        """
        if repr in self.dictPredRepr.keys():
            allLocs = list(self.dictPredRepr[repr])[
                page*self.chunk_size:(page+1)*self.chunk_size]
            print(repr, len(allLocs))
            embsStm = None
            try:
                hash = hashlib.md5(repr.encode())
                filename = os.path.join(
                    self.embeddingsFolder, prefix+str(page)+"_"+hash.hexdigest()+".pickle")
                embsStm = torch.load(filename)
            except Exception as e:
                print(f"There was a problem loading embeddings: {e}")
            return embsStm, allLocs
        print(repr, " not found")
        return None, None

    def query_from_candidates(self, locCodes, code_vecs, emb):
        """
        Query a candidate (that exists in the repr) against the set of other candidates for the repr.
        """
        # calculate
        # test using cosine:
        similarity = cosine_similarity([emb], code_vecs)
        scores = torch.tensor(similarity)

        print("scores:", scores)
        return list([(float(x), locCodes[y]) for x, y in zip(scores[0], range(len(locCodes)))])

    def get_embeddings(self, locationStm, repr):
        """
        Reads the statement and function embeddings for a sink identified by its repr and its location.
        """
        allLocs = list(self.dictPredRepr[repr])
        allLocsStm = [locStm for (_, locStm, _) in allLocs]

        # find and load the embedding for the location
        pos = allLocsStm.index(locationStm)
        page = int(pos / self.chunk_size)
        relativePos = pos % self.chunk_size
        # load page with the embedding for that enclosing stm and get embedding
        embsAllStm, locsStm = self.loadKnownSinkEmbForRepPage(
            repr,  "emb_", page)
        if embsAllStm is None:
            return None, None
        code_vec_np = embsAllStm.detach().numpy()
        embStm = code_vec_np[relativePos]
        # load page with the embedding for that enclosing func and get embedding
        embsAllFunc, locsFunc = self.loadKnownSinkEmbForRepPage(
            repr, "embF_", page)
        if embsAllFunc is None:
            return None, None
        code_vec_np = embsAllFunc.detach().numpy()
        embFunc = code_vec_np[relativePos]
        return embStm, embFunc

    def get_similar_sinks(self, embStm, embFunc, repr):
        """
        Gets sinks similar to the given pair of statement and function embeddings.
        """
        selectedLocs = set()

        if repr not in self.dictPredRepr:
            return selectedLocs

        allLocs = list(self.dictPredRepr[repr])
        page = 0
        for locs in chunks(allLocs, self.chunk_size):
            print(page)
            embsAllStm, _ = self.loadKnownSinkEmbForRepPage(
                repr,  "emb_", page)
            embsAllFunc, _ = self.loadKnownSinkEmbForRepPage(
                repr, "embF_", page)
            locsStm = [locStm for (_, locStm, _) in locs]
            locsFunc = [locFunc for (_, _, locFunc) in locs]

            code_vec_np = embsAllStm.detach().numpy()
            resultStm = self.query_from_candidates(
                locsStm, code_vec_np, embStm)
            code_vec_np = embsAllFunc.detach().numpy()
            resultFunc = self.query_from_candidates(
                locsFunc, code_vec_np, embFunc)

            for i in range(0, len(locs)):
                scoreStm, _ = resultStm[i]
                scoreFunc, _ = resultFunc[i]
                avgScore = (scoreStm+scoreFunc)/2
                if avgScore > self.threshold:
                    selectedLocs.add((locs[i][0], avgScore))
            page = page + 1

        print("Highlighted ", len(selectedLocs),
              "/", len(self.dictPredRepr[repr]))
        print(selectedLocs)
        return selectedLocs
