const WebSocket = require('faye-websocket');
const http = require('http');
const EventEmitter = require('events');

const server = http.createServer();

const ee = new EventEmitter();

server.on('upgrade', (request, socket, body) => {
  if (WebSocket.isWebSocket(request)) {
    let ws = new WebSocket(request, socket, body);

    console.log('connection is open');
    ws.on('message', (message) => {
      const msg = message.data;
      console.log(msg);
      ee.emit(msg, ws);
    });

    ws.on('close', (event) => {
      console.log('close', event.code, event.reason);
      ws = null;
    });
  }
});

ee.on('listen', listen);

function listen(ws) {
  const recs = ['Message one', 'Message two', 'Message three', 'Message four'];
  for (const rec of recs) {
    ws.send(rec);
  }
}

server.listen(5001);
