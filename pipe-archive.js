#!/usr/bin/env node

const fs = require("fs")

var log=console.log

var to_logline = msg=>new Date().toISOString()+"\t"+msg

var entry_id = 0;

var append = (message,source) => {
  try {
    entry_id++;
    const line = new Date().toISOString() + "\t" + entry_id + "\t" + source + "\t" + message

    fs.appendFile("file-v7",line+"\n",log)
  } catch (e) {
    log("append failed")
    log(e)
  }
}


var sockets = []

var addSocket = (url,name)=> {
  //'http://socket.coincap.io'
  const socket = io(url);

  socket.on( 'connect', function () {
      log( 'connected to server' );


      socket.on('trades', function (msg) {
        //log( 'trade' );
        append(msg)
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

  sockets[name]=socket;
}

addSocket('http://socket.coincap.io:80',"coincap")

//var addSocket()

//api2.bitfinex.com:3000/ws
