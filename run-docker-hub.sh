#!/bin/bash
. ./sql/run.sh
. ./set-DOCKER_HOST_IP_ADDR.sh

docker-compose --env-file .env.docker-hub pull
docker-compose --env-file .env.docker-hub up -d && echo "Try http://localhost:48082/vue-app and http://localhost:48084/web-dotvvm"