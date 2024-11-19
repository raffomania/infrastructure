#!/usr/bin/sh
set -euxo pipefail

# This script should run in the directory containing the docker-compose.yml file with the database to update.

# Inputs, as environment variables:
# db_container
# db_username
# db_volume

# Stop all containers
podman compose stop

# Then start db container
podman start "$db_container"
podman wait --condition=healthy "$db_container"

# Dump all data from the old database version to a single file
podman exec "$db_container" pg_dumpall -U "$db_username" > dump.sql

[[ ! -s dump.sql ]] && echo "dump.sql is empty" && exit 1

# Stop db container before backing up the volume
podman stop "$db_container"

# Backup data volume
volume_backup_file="$HOME/backups/$db_volume-volume-backup.tar"
podman volume export "$db_volume" -o $volume_backup_file

[[ ! -s $volume_backup_file ]] && echo "$volume_backup_file is empty" && exit 1

podman compose up -d
