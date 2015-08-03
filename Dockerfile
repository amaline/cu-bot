FROM node:latest

MAINTAINER Al Maline


RUN apt-get -q update
RUN apt-get -qy install git-core redis-server vim

RUN npm install -g hubot yo generator-hubot coffee-script ;\
    npm config -g set strict-ssl false

RUN adduser --disabled-password --gecos "" hubot; \
  echo "hubot ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD ./certs /usr/local/share/ca-certificates/

RUN update-ca-certificates

ENV HOME /home/hubot
ENV NODE_TLS_REJECT_UNAUTHORIZED 0

USER hubot
WORKDIR /home/hubot

RUN yo hubot --owner "Al Maline <amaline@yahoo.com>" --name="cubot" --description="Corporate University Robot" --adapter=slack

ADD run.sh run.sh
ADD external-scripts.json external-scripts.json
RUN ls -l && cat external-scripts.json && npm install && chmod +x run.sh

# CMD HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN ./bin/hubot --adapter slack --alias !
CMD ./run.sh
