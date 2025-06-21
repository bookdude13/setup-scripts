#!/bin/bash
set -euxo pipefail

DISTRO_SHORT=$(lsb_release -si | tr '[:upper:]' '[:lower:]')

# Assume run as root!
# Note - if running in wsl, use the windows docker instance instead

# Install dependencies
apt -y install apt-transport-https ca-certificates curl software-properties-common

# Add key

curl -fsSL https://download.docker.com/linux/$DISTRO_SHORT/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

# Add official Docker stable repository:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/$DISTRO_SHORT bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker-ce pakage:
apt update
apt -y install docker-ce docker-ce-cli containerd.io

# If you would like to use Docker as a non-root user, you should now consider adding your user to the “docker” group:
# sudo usermod -aG docker $USER
# newgrp docker

docker --version


