#!/usr/bin/env bash
# sets up web server , preparing web server for deployment

# install nginx if not already installed
sudo apt-get -y update
sudo apt-get -y install nginx

# create the required folders if not exists already
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# create fake html file to test nginx configuration
echo "Holberton School" | sudo tee /data/web_static/releases/test/index.html

# create a symbolic link 'current' linked to the 'releases/test/' folder. overite the symlink if exists
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to user 'ubuntu' AND group. -recursive
sudo useradd ubuntu
sudo chown -hR ubuntu:ubuntu /data/

# nginx serves the content of 'current' to hbnb_static
sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# start nginx if installed by this script, or restart it if it was already running
sudo service nginx start
sudo service nginx restart
