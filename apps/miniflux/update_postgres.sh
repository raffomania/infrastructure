#!/usr/bin/oil
shopt --set xtrace

# Dump all data from the old database version to a single file
podman exec miniflux_db_1 pg_dumpall -U "miniflux" > dump.sql

# Stop all containers
podman-compose stop

# Backup data volume
podman volume export miniflux_miniflux-db -o db-volume-backup.tar

# remove db container and volume
podman-compose down db
 
# Start the new container and initialize a blank database instance
podman-compose up db

# Import the dumped file into the database instance
podman exec -i miniflux_db_1 sh -c 'psql -U "miniflux" -d "miniflux"' < dump.sql

# re-start the rest
podman-compose up -d

echo "check if everything works, then remove dump.sql and db-volume-backup.tar"