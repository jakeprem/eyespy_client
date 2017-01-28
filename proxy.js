const dgram = require('dgram');
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', function connection(ws) {
    ws.send('Websocket connected!');
    console.log('Websocket connected!');

    var server = dgram.createSocket('udp4');

    server.on('message', (msg, rinfo) => {
        console.log(`server got: ${msg} from ${rinfo.address}:${rinfo.port}`);        
        ws.send(msg.toString());
    });

    server.on('listening', () => {
        var address = server.address();
        console.log(`server listening ${address.address}:${address.port}`);
    });

    server.on('error', (err) => {
        console.log(`server error:\n${err.stack}`);
        server.close();
    });
    server.bind(8083);
});

// Error handlers
wss.on('error', (err) => {
    console.log(`error error:\n{err.stack}`);
});