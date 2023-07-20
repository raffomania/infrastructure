#!/usr/bin/sh
set -euxo pipefail

# Dump all data from the old database version to a single file
podman exec miniflux_db_1 pg_dumpall -U "miniflux" > dump.sql

# Stop all containers
podman-compose stop

# Backup data volume
mkdir -p ~/backups
podman volume export miniflux_miniflux-db -o ~/backups/miniflux-db-volume-backup.tar

# remove all containers and volume
podman-compose down --volumes
 
# Start the new container and initialize a blank database instance
podman-compose up db -d

# Wait for db to start
sleep 5

# Import the dumped file into the database instance
podman exec -i miniflux_db_1 sh -c 'psql -U "miniflux" -d "miniflux"' < dump.sql

# re-start the rest
podman-compose up -d

echo "check if everything works, then remove dump.sql and db-volume-backup.tar"