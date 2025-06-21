#!/bin/bash
set -euxo pipefail

# Get htpasswd
sudo apt install apache2-utils -y

mkdir ./auth
cd ./auth

# This will prompt for the password
# Note, this creates because of -c. Run with just -B for adding more users, i.e. `htpasswd -B registry.password username`
htpasswd -Bc registry.password registry


