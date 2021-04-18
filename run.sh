#!/bin/bash
. ./sql/run.sh
. ./build.sh
export DOCKER_HOST_IP_ADDR=$(ip addr show | grep "\binet\b.*\bdocker0\b" | awk '{print $2}' | cut -d '/' -f 1)
if [[ -z $DOCKER_HOST_IP_ADDR ]]; then
    export DOCKER_HOST_IP_ADDR=host.docker.internal
fi

docker-compose up -d && echo "Try http://localhost:8082 and http://localhost:8084"