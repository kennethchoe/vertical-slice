docker run -d -p:5000:80 --env ASPNETCORE_ENVIRONMENT=Development vertical-slice/web-api
docker run -d -p:8082:80 --env WEBAPI_ENDPOINT=http://host.docker.internal:5000 vertical-slice/vue-app
