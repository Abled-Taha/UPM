import random
from passlib.hash import sha512_crypt as sha512
from flask import Flask
from pymongo import MongoClient
import config

Config = config.Config()
ipDatabase = Config.ipDatabase
portDatabase = Config.portDatabase
usernameDatabase = Config.usernameDatabase
passwordDatabase = Config.passwordDatabase

client = MongoClient(f"mongodb://{usernameDatabase}:{passwordDatabase}@{ipDatabase}")
db = client[Config.dbName]
collectionUser = db[Config.collectionUserName]

app = Flask(__name__)

def performRegChecks(key, email, username):
    resultKey = validateKey(key)
    arrayAccounts = getAccounts()
    if resultKey:
        for name, value in arrayAccounts.items():
            for name, value in value.items():
                if name == "email" and value == email:
                    return "email"
                elif name == "username" and value == username:
                    return "username"
        return True
    else:
        return False

def performLogChecks(key, email, password):
    resultKey = validateKey(key)
    arrayAccounts = getAccounts()
    if resultKey:

        def getData(id):
            for name, value in arrayAccounts.items():
                temp = 0
                for name, value in value.items():
                    if name == "_id" and value == id:
                        temp = 1
                    elif name == "salt" and temp == 1:
                        s = value
                    elif name == "hash" and temp == 1:
                        return (s, value)
            return "", ""

        def findEmail(email):
            for name, value in arrayAccounts.items():
                for name, value in value.items():
                    if name == "_id":
                        i = value
                    elif name == "email" and value == email:
                        return (i, True)
            return "", False

        foundEmail = False
        id = ""
        salt = ""
        hash = ""
        
        id, foundEmail = findEmail(email)
        if foundEmail == True and id != "":
            salt, hash = getData(id)
            if salt != "" and hash != "":
                passwordSalt = password + salt
                for name, value in Config.peppers.items():
                    passwordSaltPepper = passwordSalt + value
                    genHash = sha512.verify(passwordSaltPepper, hash)
                    if genHash:
                        return True

        return "credentials"

def validateKey(key):
    if key == Config.passwordMain:
        return True
    else:
        return False

def getAccounts():
    arrayAccounts = {}
    results = collectionUser.find()
    temp = 0
    for result in results:
        arrayAccounts[temp]=result
        temp += 1
    return arrayAccounts

@app.route('/<string:key>/reg/<string:email>/<string:password>/<string:username>')
def reg(key, email, password, username):
    result = performRegChecks(key, email, username)
    if result == True:
        # passwordEncryptionKey = Config.passwordEncryptionKey
        # password = base64.b64decode(password).decode('utf-8')
        # password = password.replace(passwordEncryptionKey, '')
        randIntP = f"{random.randint(0, Config.numberOfPeppers - 1)}"
        randIntS = f"{random.randint(0, Config.numberOfSalts - 1)}"
        salt = f"{Config.salts[randIntS]}"
        pepper = f"{Config.peppers[randIntP]}"
        passwordSalt = password + salt
        passwordSaltPepper = passwordSalt + pepper
        hash = f"{sha512.encrypt(passwordSaltPepper, rounds=5000)}"
        user = {
            'email' : email,
            'username' : username,
            'salt' : salt,
            'hash' : hash,
        }
        collectionUser.insert_one(user)
        return "done"
    elif result == False:
        return "key"
    elif result == "email":
        return "email"
    elif result == "username":
        return "username"

@app.route('/<string:key>/login/<string:email>/<string:password>')
def login(key, email, password):
    result = performLogChecks(key, email, password)
    if result == True:
        # passwordEncryptionKey = Config.passwordEncryptionKey
        # password = base64.b64decode(password).decode('utf-8')
        # password = password.replace(passwordEncryptionKey, '')
        return "Done"
    elif result == "credentials":
        return "credentials"

if __name__ == "__main__":
    app.run()
