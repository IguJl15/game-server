import * as net from 'net';


function delay(ms: number) {
   return new Promise(resolve => setTimeout(resolve, ms));
 }


const client: net.Socket = new net.Socket();

client.connect(3000, 'localhost', () => {
   console.log('Conectado ao servidor');
   console.log('Informando status ao servidor');
   client.write('Cliente OK');
});

client.on('data', (data: Buffer) => {
   console.log(`[Server] ${data.toString()}`);
});

client.on('end', () => {
   console.log('Desconectado do servidor');
});

delay(5000).then(() => 
      client.end(() => { 
         console.log("Realmente terminou!");
   })
);



 
