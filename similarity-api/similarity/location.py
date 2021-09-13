from xml.etree.ElementTree import tostring
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
    def __hash__(self):
        return  self.toStringFlat().__hash__()
    
    def __eq__(self, other):
        return self.toStringFlat() == other.toStringFlat() 

    def __str__(self):
        return self.toString()
    
    __repr__ = __str__

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

    def __str__(self):
        return self.toString()
        
    def read(self, prefix:str):
        try:
            db = self.db.replace("/","_")
            zipFilename = os.path.join(prefix,db,"src.zip")
            archive = zipfile.ZipFile(zipFilename, 'r')
            path = self.path.replace('"',"")
            with archive.open("opt/src/"+path) as source:
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
            print("Error trying to read location:", self.toString(), "zip: ", zipFilename, "path:", self.path)
            print(inst)   
            # raise    
            result = ""

        return result

    
    def db(self):
        return self.db


def getCodes(locs, baseFolder):
    result = []
    for ksLoc in locs:
        ksCode = ksLoc.read(os.path.join(baseFolder))
        result.append(ksCode)
    return result
