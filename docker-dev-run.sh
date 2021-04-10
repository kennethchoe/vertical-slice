#!/bin/bash
. ./sql/docker-run.sh
docker run -d --rm -p:5000:80 --env ASPNETCORE_ENVIRONMENT=Development --env ConnectionStrings__DefaultConnection="Data Source=host.docker.internal,1401; User Id=sa; Password=StrongP@ssw0rd; Initial Catalog=vertical-slice;" vertical-slice/web-api
docker run -d --rm -p:8082:80 --env VerticalSliceConfig__ApiEndpoint=http://host.docker.internal:5000 vertical-slice/vue-app
docker run -d --rm -p:8083:80 --env VerticalSliceConfig__ApiEndpoint=http://host.docker.internal:5000 vertical-slice/web-dotvvm
