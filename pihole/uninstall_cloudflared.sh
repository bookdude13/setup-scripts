#!/bin/bash

sudo systemctl stop cloudflared
sudo systemctl disable cloudflared
sudo systemctl daemon-reload
sudo deluser cloudflared
sudo rm /etc/default/cloudflared
sudo rm /etc/systemd/system/cloudflared.service
sudo rm /usr/local/bin/cloudflared

