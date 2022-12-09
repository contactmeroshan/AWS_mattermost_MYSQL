#!/bin/bash
wget https://releases.mattermost.com/5.19.0/mattermost-5.19.0-linux-amd64.tar.gz
echo "Downloaded Mattermost"
tar -xvzf mattermost*.gz
echo "Extracted Mattermost"
mv mattermost /opt
mkdir /opt/mattermost/data
useradd --system --user-group mattermost
echo "Created user"
sed "s/localhost:3306/$1:3306/" /opt/mattermost/config/config.json > config.json
mv config.json /opt/mattermost/config/config.json
