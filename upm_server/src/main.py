import config
from server import app

Config = config.Config()
ipServer = Config.ipServer
portServer = Config.portServer
debug = Config.debug
 
if __name__ == '__main__':
   app.run(debug=debug, host=ipServer, port=portServer)