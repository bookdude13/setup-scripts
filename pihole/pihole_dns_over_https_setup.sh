#!/bin/bash

# Select the appropriate upstream for Cloudflare or Quad9
#DNS_UPSTREAM=https://cloudflare-dns.com/dns-query
DNS_UPSTREAM=https://dns11.quad9.net/dns-query

# Needs to be run as root!
if [ $UID != 0 ]; then
    echo "Needs to run as root; use sudo"
    exit 1
fi

if [ ! -f /usr/local/bin/cloudflared ]; then
    echo "Installing cloudflared..."
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm
    sudo mv -f ./cloudflared-linux-arm /usr/local/bin/cloudflared
    sudo chmod +x /usr/local/bin/cloudflared
    cloudflared -v
fi

echo "Configuring to run on startup..."

CLOUDFLARE_USER=$(awk -F':' '{ print $1}' /etc/passwd | grep cloudflared)
if [ "$CLOUDFLARE_USER" != "cloudflared" ]; then
    echo "Adding user for cloudflared"
    sudo useradd -s /usr/sbin/nologin -r -M cloudflared
fi

CONFIG_PATH=/etc/default/cloudflared

#if [ ! -f $CONFIG_PATH ]; then
echo "Setting up $CONFIG_PATH (note, this overwrites the existing file)..."
echo "# Commandline args for cloudflared, using Cloudflare DNS" > $CONFIG_PATH
echo "CLOUDFLARED_OPTS=--port 5053 --upstream $DNS_UPSTREAM" >> $CONFIG_PATH

echo "Updating ownership of binary and config..."
chown cloudflared:cloudflared /etc/default/cloudflared
chown cloudflared:cloudflared /usr/local/bin/cloudflared

echo "Adding cloudlfared service..."
cp ./cloudflared.service /etc/systemd/system/cloudflared.service

echo "Enable service..."
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
sudo systemctl status --output=cat cloudflared

echo "Add updater..."
sudo cp ./cloudflared-updater /etc/cron.weekly/cloudflared-updater
sudo chmod +x /etc/cron.weekly/cloudflared-updater
sudo chown root:root /etc/cron.weekly/cloudflared-updater

echo "Run test..."
dig @127.0.0.1 -p 5053 google.com

