#!/bin/bash
. ./sql/run.sh
. ./set-DOCKER_HOST_IP_ADDR.sh

rm k8s-transformed -r
mkdir k8s-transformed

for f in ./k8s/*.yaml; do
    fname=`basename -- "$f"`
    cat "k8s/$fname" | envsubst > "k8s-transformed/$fname"
done

kubectl apply -f k8s-transformed/ \
    && echo "Try http://$DOCKER_HOST_NAME/vue-app and http://$DOCKER_HOST_NAME/web-dotvvm" \
