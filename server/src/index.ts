import * as net from 'net';

const server: net.Server = net.createServer()
const activeConnections = new Map<String, net.Socket>()

server.on("connection", (socket: net.Socket) => {
   activeConnections.set(`${socket.remoteAddress}:${socket.remotePort}`, socket)
   
   console.log(`[Server] Current connections:`)
   for (const connection of activeConnections.keys()){
      console.log(connection);
   }
   
   socket.on("connect", () => {
      console.log(`[Server] Cliente que acaba de conectar: ${socket.remoteAddress}:${socket.remotePort}`);
   })

   socket.on("ready", () => { console.log("Client ready") })
   socket.on("data", (data) => { 
      console.log(`[Client] ${data}`)
      socket.write("Escutado. Beleza, vlw 👍")
   })

   socket.on('close', (hadError) => {
      console.log(`[Server] Conexão com ${socket.remoteAddress} finalizada` + (hadError ? " com erros" : ""))
      activeConnections.delete(`${socket.remoteAddress}:${socket.remotePort}`)
   })
})

server.on('end', () => {
   console.log('Server ended');
});

   static sendMessageToPlayer(state: any, playerId: string) { 
      console.log(`sending message to player ${playerId}`);
      
      this.activeConnections.get(playerId)?.write(JSON.stringify(state)) 
   }
