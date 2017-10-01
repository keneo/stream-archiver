#!/usr/bin/env node

const io = require("socket.io-client")

var log=console.log

const socket = io('http://socket.coincap.io:80');

socket.on( 'connect', function () {
  log( 'connected to server' );

  socket.on('trades', message=>{
    //log( 'trade' );
    log(JSON.stringify(message))
  })
} );


socket.on( 'disconnect', function () {
    log( 'disconnected to server' );
} );

//
// socket.on('*', function (data,d2) {
//     log( 'message' );
//     //console.log(JSON.stringify(tradeMsg))
//     //console.log(tradeMsg);//.replace("\n","\t")+",");
//     append(data)
//     append(d2)
// })
//
// socket.on('trades', function (data) {
//     log( 'trades' );
//     //console.log(JSON.stringify(tradeMsg))
//     //console.log(tradeMsg);//.replace("\n","\t")+",");
//     append(data)
// })


//var addSocket()

//api2.bitfinex.com:3000/ws
