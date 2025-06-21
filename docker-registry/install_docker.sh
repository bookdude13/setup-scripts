#!/bin/bash

# Assume run as root!

# Install dependencies
apt -y install apt-transport-https ca-certificates curl software-properties-common

# Add official Docker stable repository:
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install docker-ce pakage:
apt update
apt -y install docker-ce docker-ce-cli containerd.io

# If you would like to use Docker as a non-root user, you should now consider adding your user to the “docker” group:
# sudo usermod -aG docker $USER
# newgrp docker

docker --version


