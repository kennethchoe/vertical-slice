#!/bin/bash
# echo list of images to be docker-pushed.
sed -n -e 's/^[ \t]*image: ${DOCKER_REGISTRY}//p' docker-compose.yml
