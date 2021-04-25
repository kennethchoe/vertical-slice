#!/bin/bash
. ./sql/run.sh
. ./set-DOCKER_HOST_IP_ADDR.sh

. ./build.sh
docker-compose up -d && echo "Try http://localhost:8082 and http://localhost:8084"