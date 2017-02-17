#!/bin/bash
set -e
INVENTORY="$1"
if [ -z $INVENTORY ]; then
    echo "usage: $0 <inventory-file>"
    exit 1
fi
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" redis:alpine
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" python:3-alpine
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" jeko/couchdb:1.6.1
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" jeko/haproxy-redis-lb:direct
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" jeko/marathon-redis-sentinel:direct
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" ganomede/data:v0.1.2
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" ganomede/directory:v0.0.4
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" ganomede/events:v1.0.1
fovea-marathon-base/scripts/broadcast-docker-image.sh "$INVENTORY" ganomede/avatars:v1.0.7
