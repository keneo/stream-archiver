#!/usr/bin/env node


var request = require("request");

var options = { method: 'GET', url: 'https://api.bitfinex.com/v1/symbols' };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  const allSymbols = JSON.parse(body)

  const ws = require('ws')
  const w = new ws('wss://api.bitfinex.com/ws/2')

  w.on('message', (msg) => console.log(msg))

  w.on('open', () => {
    allSymbols.forEach(symbol=>{
      const allToSend = [
        {
          event: 'subscribe',
          channel: 'ticker',
          symbol: symbol
        },{
          event: "subscribe",
          channel: "trades",
          symbol: symbol
        }
        ,{
          event: "subscribe",
          channel: "book",
          prec: "R0",
          symbol: symbol,
          len: 100
        }
      ];
      allToSend.forEach(m=>w.send(JSON.stringify(m)));
    })
  })

});
