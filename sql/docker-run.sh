#!/bin/bash
DockerSqlPort=1401
DockerSaPassword="StrongP@ssw0rd"

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

docker run -d  -p:$DockerSqlPort:1433 --label 'vertical-slice-sql' \
    -e 'ACCEPT_EULA=Y' \
    -e 'MSSQL_SA_PASSWORD=P@ssw0rd' \
    mcr.microsoft.com/mssql/server:2017-latest

export existingContainerId="$(docker ps -aq --filter label=vertical-slice-sql)"

# wait until the service launches: need better way
sleep 10

# initial password is available via EV. change it for security purposes.
docker exec -it $existingContainerId /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U SA -P 'P@ssw0rd' \
   -Q 'ALTER LOGIN SA WITH PASSWORD="'$DockerSaPassword'"'

# restore backup
rm ./backup/*.bak -f
tar -xvf vertical-slice-legacy-backup.tar.gz --directory backup

docker exec -it $existingContainerId mkdir /var/opt/mssql/backup
docker cp $PWD/backup/*.bak $existingContainerId:/var/opt/mssql/backup

docker exec -it $existingContainerId /opt/mssql-tools/bin/sqlcmd -S localhost \
   -U SA -P $DockerSaPassword \
   -Q 'RESTORE DATABASE [vertical-slice] FROM DISK = "/var/opt/mssql/backup/vertical-slice.bak"
   WITH MOVE "vertical-slice" TO "/var/opt/mssql/data/vertical-slice.mdf",
        MOVE "vertical-slice_log" TO "/var/opt/mssql/data/vertical-slice_log.ldf"
   '
