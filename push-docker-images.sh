#!/bin/bash
imageNamePrefix=$1
tagname1=$2
tagname2=$3

#break build script for any error
#https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -e

./build.sh

imageNames=(`sed -n -e 's/^[ \t]*image: ${DOCKER_REGISTRY}//p' docker-compose.yml`)
for imageName in "${imageNames[@]}"
do
    imageId=`docker images -q $imageName`
    docker tag $imageId "$imageNamePrefix/$imageName:$tagname1"
    docker push "$imageNamePrefix/$imageName:$tagname1"

    if [[ -n $tagname2 ]]; then
        docker tag $imageId "$imageNamePrefix/$imageName:$tagname2"
        docker push "$imageNamePrefix/$imageName:$tagname2"
    fi
    
    docker rmi -f $imageId
done