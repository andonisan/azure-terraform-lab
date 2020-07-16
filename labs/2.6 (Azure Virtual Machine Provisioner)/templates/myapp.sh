#!/bin/bash
export HOME=/root
apt-get update
apt-get upgrade -y
apt-get install -y wget curl build-essential libssl-dev git unattended-upgrades
cd /root
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 10.11
npm install pm2 -g
git clone https://github.com/heroku/node-js-getting-started.git
cd node-js-getting-started
npm install
pm2 start index.js