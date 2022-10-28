import json

class Config():
    def __init__(self):
        pathConfig = "../config.json"
        with open(pathConfig) as file:
            _config = json.load(file)
            self.usernameDatabase = _config["usernameDatabase"]
            self.passwordDatabase = _config["passwordDatabase"]
            self.ipDatabase = _config["ipDatabase"]
            self.portDatabase = _config["portDatabase"]
            self.ipServer = _config["ipServer"]
            self.portServer = _config["portServer"]
            self.dbName = _config["dbName"]
            self.collectionUserName = _config["collectionUserName"]
            self.passwordMain = _config["passwordMain"]
            self.passwordEncryptionKey = _config["passwordEncryptionKey"]
            self.numberOfSalts = _config["numberOfSalts"]
            self.salts = _config["salts"]
            self.numberOfPeppers = _config["numberOfPeppers"]
            self.peppers = _config["peppers"]
            self.debug = _config["debug"]