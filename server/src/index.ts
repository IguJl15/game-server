import * as net from 'net';
import Director from './api/Director';
import { Board } from './game/entities/Board';

export default
   class SocketServer {

   private server: net.Server
   director = new Director();
   static currentConnection: net.Socket | null
   static activeConnections = new Map<string, net.Socket>()
   
   constructor() {
      this.server = net.createServer()
      
      this.server.on("connection", (socket: net.Socket) => {
         const connectionName = `${socket.remoteAddress}:${socket.remotePort}`

         socket.on("connect", () => {
            console.log(`[Server] Cliente que acaba de conectar: ${socket.remoteAddress}:${socket.remotePort}`);
         })

         socket.on("data", (data: Buffer) => {
            SocketServer.currentConnection = socket
            try {
               const json = JSON.parse(data.toString())

               const action = Object.keys(json)[0]!
               const response = Director.direct(action, json)

               if (!response) throw new Error();
               console.log(`Response to client: ${response}`);

               socket.write(JSON.stringify(response));

               // map players to connections
               if ('CreateGame' in json) {
                  const playerId = (response as {GameState:Board}).GameState.player1.userId!
                  SocketServer.activeConnections.set(playerId, socket);
               }
            } catch (error) {
               console.log(error);
            } finally {
               SocketServer.currentConnection = null
            }
         })

         socket.on('close', (hadError) => {
            console.log(`[Server] Conexão com ${connectionName} finalizada` + (hadError ? " com erros" : ""))

            for (const [playerId, storedSocket] of SocketServer.activeConnections.entries()) {
               if (storedSocket == socket) {
                  SocketServer.activeConnections.delete(playerId)
                  Director.direct("CloseGame", {"playerId": playerId})
               }
            }
         })
      })

      this.server.on('end', () => {
         console.log('Server ended');
      });

      this.server.on("close", () => {
         console.log("Servidor fechado")
      })
   }
   start(port: number) {
      this.server.listen(port, () => {
         console.log(`Servidor inicializado na porta ${port}`);
      });
   }

   static sendMessageToPlayer(state: any, playerId: string) { 
      console.log(`sending message to player ${playerId}`);
      
      this.activeConnections.get(playerId)?.write(JSON.stringify(state)) 
   }
}





const socketServer = new SocketServer()

socketServer.start(3000)