FROM debian:stable-20170907

# RUN yum update -y
RUN apt-get update
RUN apt-get install -y curl gnupg

RUN curl -sL https://deb.nodesource.com/setup_8.x |bash -

RUN apt-get install -y nodejs


#RUN yum install -y node
# RUN apt-get install -y socat

RUN mkdir /action

COPY node_modules /action/node_modules/

COPY *.sh /action/
COPY *.js /action/


WORKDIR /action/

CMD ./cmd.sh
