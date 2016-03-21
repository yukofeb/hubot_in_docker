FROM ubuntu
MAINTAINER yukofeb <yuko.february@gmail.com>

# Install packages 
RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN useradd -d /home/hubot -m -s /bin/bash -U hubot

# Log in as hubot user
USER hubot
WORKDIR /home/hubot

# Install hubot
Run yo hubot --owner="yukofeb" --name="Hubot" --description="Hubot in docker" --defaults

# Configure
#ADD $HOME/$CIRCLE_PROJECT_REPONAME/files/external-scripts.json /home/hubot/ 
#ADD $HOME/$CIRCLE_PROJECT_REPONAME/scripts/*.coffee /home/hubot/scripts/

# Support slack
#RUN npm install hubot-slack --save && npm install
#CMD bin/hubot -a slack
