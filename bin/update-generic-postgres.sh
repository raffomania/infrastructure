#!/usr/bin/sh
set -euxo pipefail

# This script should run in the directory containing the docker-compose.yml file with the database to update.

# Inputs, as environment variables:
# db_container
# db_username
# db_volume

# Pull any new containers beforehand
podman compose pull

# Dump all data from the old database version to a single file
podman exec "$db_container" pg_dumpall -U "$db_username" > dump.sql

[[ ! -s dump.sql ]] && echo "dump.sql is empty" && exit 1

# Stop all containers
podman compose stop

# Backup data volume
volume_backup_file="$HOME/backups/$db_volume-volume-backup.tar"
podman volume export "$db_volume" -o $volume_backup_file

[[ ! -s $volume_backup_file ]] && echo "$volume_backup_file is empty" && exit 1

# remove db container & volume
podman compose down db
podman volume rm "$db_volume"
 
# Start the new container and initialize a blank database instance
podman compose up db -d

# Wait for db to start
podman wait --condition=healthy "$db_container"

# Import the dumped file into the database instance
podman exec -i "$db_container" sh -c "psql -U $db_username" < dump.sql

# re-start the rest
podman compose up -d

echo "check if everything works, then remove dump.sql and db volume backup in ~/backups"
