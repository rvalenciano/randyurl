#!/bin/bash
# install node.js and npm the expected way
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs > /dev/null
sudo apt-get install -y npm > /dev/null
sudo npm install --global gulp > /dev/null
sudo npm install -g yo > /dev/null
sudo ln -s -f /usr/bin/nodejs /usr/bin/node
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn > /dev/null