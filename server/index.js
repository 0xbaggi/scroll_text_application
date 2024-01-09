const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const path = require('path'); 

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

app.use(express.static('public'));

// Serve the controller.html file at /controller
app.get('/controller', (req, res) => {
  res.sendFile(path.join(__dirname, '/public/controller.html'));
});

// Serve the trackpad.html file at /trackpad
app.get('/trackpad', (req, res) => {
    res.sendFile(path.join(__dirname, '/public/trackpad.html'));
  });
let windowOrderCounter = 1;
let activeWindows = {};

io.on('connection', (socket) => {
    socket.on('identify', (page) => {
        if (page === '/controller') {
            console.log('Controller connected, not counted as an active window');
        } else if (page === '/trackpad') {
            console.log('Trackpad connected, not counted as an active window');
        } else if (page === '/window') {
            const currentOrder = windowOrderCounter++;
            activeWindows[socket.id] = currentOrder;
            console.log(`Window ${currentOrder} connected`);
            socket.emit('windowOrder', currentOrder);
            io.emit('updateTotalWindows', Object.keys(activeWindows).length);
        }
    });

    socket.on('moveContent', (data) => {
        socket.broadcast.emit('adjustDivPosition', data);
    });

    socket.on('sendHtmlContent', (data) => {
        socket.broadcast.emit('updateContent', data);
    });

    socket.on('updateWidth', (width) => {
        // Broadcast the new width to all connected clients
        io.emit('setWidth', width);
    });

    socket.on('disconnect', () => {
        if (activeWindows[socket.id]) {
            console.log(`Window ${activeWindows[socket.id]} disconnected`);
            delete activeWindows[socket.id];
            updateWindowOrders();
        } else {
            console.log('Controller disconnected');
        }
    });

    socket.on('resetPosition', (data) => {
        io.emit('resetPosition', data);
    });
});

function updateWindowOrders() {
    windowOrderCounter = 1;
    for (let id in activeWindows) {
        activeWindows[id] = windowOrderCounter++;
        io.to(id).emit('windowOrder', activeWindows[id]);
    }
}

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
