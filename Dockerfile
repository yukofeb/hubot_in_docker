FROM ubuntu
MAINTAINER yukofeb <yuko.february@gmail.com>

# Install packages 
RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user
USER hubot
WORKDIR /hubot

# Install hubot
Run yo hubot --owner="yukofeb" --name="Hubot" --description="Hubot in docker" --defaults

# Configure
ADD files/external-scripts.json ./ 
ADD scripts/*.coffee scripts/

# Support slack
RUN npm install hubot-slack --save && npm install
CMD bin/hubot -a slack
