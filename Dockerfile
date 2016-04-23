FROM ubuntu
MAINTAINER yukofeb <yuko.february@gmail.com>

# Install packages 
RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot
RUN npm install -g forever

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
ADD scripts/*.json scripts/

# Support slack
RUN npm install hubot-slack cron time --save && npm install
#CMD bin/hubot -a slack
CMD forever start -w -c coffee bin/hubot -a slack
