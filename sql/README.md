# vertical-slice SQL

## Assumption
You have a backup of sql database that you want to start from. In this example, it is zipped and committed as part of repo.

## Commands

### `docker-run.sh`
1. Launch SQL container and restore the database from the backup.
2. If SQL container exists but stopped, just start it.
3. If SQL container exists and running, do nothing.

SQL container is recognized by its label, `vertical-slice-sql`.

### `docker-run-fresh.sh`
If SQL container exists, delete it first, and then run `docker-run.sh`.