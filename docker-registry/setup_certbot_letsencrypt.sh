#!/bin/bash
set -euxo pipefail

DOMAIN_NAME="registry.rfredlund.com"

sudo apt install -y certbot python3-certbot-nginx

certbot --nginx -d $DOMAIN_NAME

