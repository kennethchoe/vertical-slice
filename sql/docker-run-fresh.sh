#!/bin/bash
export existingContainerId="$(docker ps -aq --filter label=vertical-slice-sql)"
if [[ -n $existingContainerId ]]; then
    export existingContainerStatus="$(docker inspect --type container $existingContainerId --format='{{.State.Status}}')"
    if [[ $existingContainerStatus = "running" ]]; then
        docker container stop $existingContainerId
    fi
    docker container rm $existingContainerId
fi

. docker-run.sh