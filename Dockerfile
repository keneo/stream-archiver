FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y nodejs npm
# RUN apt-get install -y socat

COPY package.json .
COPY stream-archiver.js .

RUN npm install

CMD npm start
