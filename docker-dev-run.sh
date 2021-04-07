#!/bin/bash
. ./sql/docker-run.sh
docker run -d -p:5000:80 --env ASPNETCORE_ENVIRONMENT=Development --env ConnectionStrings:DefaultConnection="Data Source=host.docker.internal,1401; User Id=sa; Password=StrongP@ssw0rd; Initial Catalog=vertical-slice;" vertical-slice/web-api
docker run -d -p:8082:80 --env WEBAPI_ENDPOINT=http://host.docker.internal:5000 vertical-slice/vue-app
