#!/bin/bash
DockerSqlPort=1401
DockerSaPassword="StrongP@ssw0rd"

export existingContainerId="$(docker ps -aq --filter label=vertical-slice-sql)"
if [[ -n $existingContainerId ]]; then
    export existingContainerStatus="$(docker inspect --type container $existingContainerId --format='{{.State.Status}}')"
    if [[ $existingContainerStatus = "running" ]]; then
        echo "SQL Server container found running: $existingContainerId"
        [[ $SHLVL -gt 2 ]] && return || exit
    fi
    docker start $existingContainerId
    echo "SQL Server container start: $existingContainerId"
    [[ $SHLVL -gt 2 ]] && return || exit
fi

docker run -d  -p:$DockerSqlPort:1433 --label 'vertical-slice-sql' \
    -e 'ACCEPT_EULA=Y' \
    -e 'MSSQL_SA_PASSWORD=P@ssw0rd' \
    mcr.microsoft.com/mssql/server:2017-latest

export existingContainerId="$(docker ps -aq --filter label=vertical-slice-sql)"

# wait until the service launches
until docker exec -it $existingContainerId /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U SA -P 'P@ssw0rd' \
   -Q 'select "SQL service is available now."'; do
    >&2 echo "SQL service is not available yet - waiting..."
    sleep 1
done

# initial password is available via EV. change it for security purposes.
docker exec -it $existingContainerId /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U SA -P 'P@ssw0rd' \
   -Q 'ALTER LOGIN SA WITH PASSWORD="'$DockerSaPassword'"'

# restore backup
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
rm $DIR/backup/*.bak -f
tar -xvf $DIR/vertical-slice-legacy-backup.tar.gz --directory $DIR/backup

docker exec -it $existingContainerId mkdir /var/opt/mssql/backup
docker cp $DIR/backup/*.bak $existingContainerId:/var/opt/mssql/backup

docker exec -it $existingContainerId /opt/mssql-tools/bin/sqlcmd -S localhost \
   -U SA -P $DockerSaPassword \
   -Q 'RESTORE DATABASE [vertical-slice] FROM DISK = "/var/opt/mssql/backup/vertical-slice.bak"
   WITH MOVE "vertical-slice" TO "/var/opt/mssql/data/vertical-slice.mdf",
        MOVE "vertical-slice_log" TO "/var/opt/mssql/data/vertical-slice_log.ldf"
   '
