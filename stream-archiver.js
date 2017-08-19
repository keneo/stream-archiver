const io = require("socket.io-client")

var socket = io.connect('http://socket.coincap.io');

socket.on('trades', function (tradeMsg) {
    console.log(JSON.stringify(tradeMsg))
    //console.log(tradeMsg);//.replace("\n","\t")+",");
})

socket.on('global', function (globalMsg) {
  console.log(JSON.stringify(globalMsg))
})
