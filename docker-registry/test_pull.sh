#!/bin/bash
set -euxo pipefail

REGISTRY_DOMAIN=localhost:5000

docker login https://$REGISTRY_DOMAIN
docker pull $REGISTRY_DOMAIN/test-image

docker run -it $REGISTRY_DOMAIN/test-image /bin/bash
