import zipfile
import os

class Location:
    def __init__(self, db, path, startLine, startColumn, endLine, endColumn):
        self.db = db
        self.path = path
        self.startLine = startLine
        self.startColumn = startColumn
        self.endLine = endLine
        self.endColumn = endColumn

    def as_dict(self):
        return {
            "projectName": self.db,
            "path": self.path.replace("opt/src/", "", 1),
            "startLine": self.startLine,
            "startColumn": self.startColumn,
            "endLine": self.endLine,
            "endColumn": self.endColumn
        }

    def fromString(locStr):
        locDB = locStr.replace("\"", "").split("||")
        url = locDB[1]
        locArray = url.replace("\"", "").split(":")
        db = locDB[0].strip()
        startLine = int(locArray[2])
        startColumn = int(locArray[3])
        endLine = int(locArray[4])
        endColumn = int(locArray[5])
        path = locArray[1][3:]
        return Location(db, path, startLine, startColumn, endLine, endColumn)

    def toString(self):
        return self.db+"||"+"file:///opt/src/"+self.path+":"+str(self.startLine)+":"+str(self.startColumn)+":"+str(self.endLine)+":"+str(self.endColumn)

    def toStringFlat(self):
        return self.db.replace("/","_")+"||"+"file:///opt/src/"+self.path+":"+str(self.startLine)+":"+str(self.startColumn)+":"+str(self.endLine)+":"+str(self.endColumn)

    def read(self, prefix:str):
        try:
            db = self.db.replace("/","_")
            zipFilename = os.path.join(prefix,db,"src.zip")
            archive = zipfile.ZipFile(zipFilename, 'r')
            with archive.open("file:///opt/src/"+self.path) as source:
                lines = source.readlines()
                # lines = text.split('\n')
                # print(len(lines))
                result = ""
                if(self.endLine>self.startLine):
                    result += lines[self.startLine-1].decode('utf-8')[self.startColumn-1:]
                    for i in range(self.startLine+1,self.endLine-1):
                        # print(lines[i-1])
                        text = lines[i-1].decode('utf-8')
                        result += text
                    result += lines[self.endLine-1].decode('utf-8')[:self.endColumn]
                else:
                    result += lines[self.startLine-1].decode('utf-8')[self.startColumn-1:self.endColumn]
        
        except Exception as inst:
            print("Error in readLocation:", self.toString(), "zip: ", zipFilename)
            print(inst)   
            # raise    
            result = ""

        return result

    
    def db(self):
        return self.db


def readLocation(location:str, prefix:str):
    try: 
        locDB = location.split("||")
        db = locDB[0].strip().replace("/","_")
        url = locDB[1].replace("\"","")
        locArray = url.replace("\"","").split(":")
        startLine = int(locArray[2])
        startColumn = int(locArray[3])
        endLine = int(locArray[4])
        endColumn = int(locArray[5])
        fileName = locArray[1][3:]

        # print(prefix+db+"/src.zip")
        zipFilename = os.path.join(prefix,db,"src.zip")
        archive = zipfile.ZipFile(zipFilename, 'r')
        # print(fileName)
        # print(startLine)
        # print(endLine)
        with archive.open(fileName) as source:
            lines = source.readlines()
            # lines = text.split('\n')
            # print(len(lines))
            result = ""
            if(endLine>startLine):
                result += lines[startLine-1].decode('utf-8')[startColumn-1:]
                for i in range(startLine+1,endLine-1):
                    # print(lines[i-1])
                    text = lines[i-1].decode('utf-8')
                    result += text
                result += lines[endLine-1].decode('utf-8')[:endColumn]
            else:
                result += lines[startLine-1].decode('utf-8')[startColumn-1:endColumn]
            # print(result)
    except Exception as inst:
        print("Error in readLocation:", location, "zip: ", zipFilename)
        print(inst)   
        # raise    
        result = ""
        if "None" in location:
            raise
    return result


def getCodes(locs, baseFolder, queryType):
    result = []
    for ksLoc in locs:
        ksCode = readLocation(ksLoc, os.path.join(baseFolder, queryType))
        result.append(ksCode)
    return result
