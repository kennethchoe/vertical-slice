#!/bin/bash
. ./sql/run.sh
. ./build.sh
export DOCKER_HOST_IP_ADDR=$(ip addr show | grep "\binet\b.*\bdocker0\b" | awk '{print $2}' | cut -d '/' -f 1)
docker-compose up -d
echo "Try http://localhost:8082 and http://localhost:8084"