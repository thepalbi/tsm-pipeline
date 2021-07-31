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

    def db(self):
        return self.db
