FROM ubuntu:16.04

RUN apt-get install nodejs

COPY cmd.sh .

CMD bash cmd.sh
