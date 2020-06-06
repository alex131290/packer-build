#!/bin/bash -x
set -e

sudo apt-get update
sudo rm -rvf /var/lib/apt/lists/*

sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse

sudo apt-get update

sudo apt-get install nginx -y
sudo cp /home/$(whoami)/pkg/app/bin/app_linux64 /usr/local/bin/dragontail
sudo chmod +x /usr/local/bin/dragontail

sudo bash -c 'cat << EOF >> /etc/systemd/system/dragontail.service
[Unit]
Description=dragontail

[Service]
Type=simple
Restart=always
ExecStart=/usr/local/bin/dragontail

[Install]
WantedBy=multi-user.target
'
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
sudo cp /home/$(whoami)/pkg/nginx/default /etc/nginx/sites-available/default
nginx -t
sudo systemctl start dragontail.service 