FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y nodejs npm
RUN apt-get install -y socat

#COPY cmd.sh .

CMD bash -c "echo socat - TCP:socket.coincap.io:80,crnl"
