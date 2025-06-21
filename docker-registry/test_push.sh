#!/bin/bash
set -euxo pipefail

REGISTRY_DOMAIN=localhost:5000

echo "Creating interactive shell. Do 'touch /SUCCESS' inside to test, then 'exit'"
docker run -t -i ubuntu /bin/bash

docker commit $(docker ps -lq) test-image
docker tag test-image $REGISTRY_DOMAIN/test-image 

docker login https://$REGISTRY_DOMAIN
docker push $REGISTRY_DOMAIN/test-image

