#!/bin/bash

apt install nginx apache2-utils -y

DOMAIN_NAME=registry.rfredlund.com
echo "Copying config file for registry w/ domain name '$DOMAIN_NAME'"
cat nginx_registry.conf | sed "s/DOMAIN_NAME/$DOMAIN_NAME/g" > /etc/nginx/conf.d/registry.conf

echo "Open up /etc/nginx/nginx.conf and copy the following inside of the http block"
echo "
# Added for docker registry. Allow larger blob uploads.
client_max_body_size 4000m;
server_names_hash_bucket_size 64;
"

echo ""
echo "After adding, restart nginx with 'systemctl restart nginx'"

