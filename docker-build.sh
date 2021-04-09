#!/bin/bash
docker build ./web-api/src -t vertical-slice/web-api
docker build ./vue-app/src -t vertical-slice/vue-app
docker build ./web-dotvvm/src -t vertical-slice/web-dotvvm
