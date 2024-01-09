const socket = io();
socket.emit('identify', '/window');

let windowOrder;
let WINDOW_WIDTH = window.innerWidth; 
let totalWindows = 1;
const movableDiv = document.getElementById('movableDiv');

// Set a default position for the div (adjust as needed)
const defaultLeft = '50px';
const defaultTop = '50px';

movableDiv.style.left = defaultLeft;
movableDiv.style.top = defaultTop;

socket.on('updateTotalWindows', (data) => {
    totalWindows = data;
});

socket.on('windowOrder', (order) => {
    windowOrder = order;
    updateDivPosition({ x: parseInt(movableDiv.style.left, 10), y: parseInt(movableDiv.style.top, 10) });
});

socket.on('divMoved', function(data) {
    updateDivPosition(data);
});

socket.on('adjustDivPosition', (data) => {
    // Adjust the div's position based on received movement data
    let currentLeft = parseInt(movableDiv.style.left, 10) || 0;
    let currentTop = parseInt(movableDiv.style.top, 10) || 0;
    movableDiv.style.left = (currentLeft + data.movementX) + 'px';
    movableDiv.style.top = (currentTop + data.movementY) + 'px';
    updateWidth();
});

socket.on('updateContent', (data) => {
    movableDiv.innerHTML = data.content;
    updateWidth();
    movableDiv.style.height = data.size.height + 'px';
});

socket.on('resetPosition', (data) => {
    if(data) {
        updateDivPosition({ x: parseInt(data.x, 10), y: parseInt(data.y, 10) });
    } else {
        updateDivPosition({ x: parseInt(defaultLeft, 10), y: parseInt(defaultTop, 10) });
    }
});

movableDiv.ondragstart = function() {
    return false;
};

function updateWidth() {
    // Calculate the number of windows to the right of the current window, including the current one
    let windowsToRight = totalWindows - getSequencePosition(windowOrder);

    // Calculate the new width based on the windows to the right and the current left position of the div
    let newWidth = (windowsToRight * WINDOW_WIDTH) - parseInt(movableDiv.style.left, 10);

    // Set the width of the movableDiv
    movableDiv.style.width = newWidth + 'px';
}


function updateDivPosition(data) {
    let sequencePosition = getSequencePosition(windowOrder);

    // Adjust the X position based on the window's sequence position
    const localX = data.x - sequencePosition * WINDOW_WIDTH;
    const localY = data.y;
    movableDiv.style.left = localX + 'px';
    movableDiv.style.top = localY + 'px';
}

function getSequencePosition(order) {
    if (order % 2 === 1) {
        return Math.ceil(totalWindows / 2) - Math.ceil(order / 2);
    } else {
        return Math.floor(totalWindows / 2) + order / 2;
    }
}