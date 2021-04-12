#!/bin/bash
. ./sql/run.sh
. ./build.sh
docker compose up -d
echo "Try http://localhost:8082 and http://localhost:8084"