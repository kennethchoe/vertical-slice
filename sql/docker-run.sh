#!/bin/bash
export existingContainerId="$(docker ps -aq --filter label=vertical-slice-sql)"
if [[ -n $existingContainerId ]]; then
    export existingContainerStatus="$(docker inspect --type container $existingContainerId --format='{{.State.Status}}')"
    if [[ $existingContainerStatus = "running" ]]; then
        echo "container found running: $existingContainerId"
        exit
    fi
    docker start $existingContainerId
    echo "docker start: $existingContainerId"
    exit
fi

docker run -d --env ACCEPT_EULA=Y --label vertical-slice-sql mcr.microsoft.com/mssql/server:2017-latest
export existingContainerId="$(docker ps -aq --filter label=vertical-slice-sql)"
