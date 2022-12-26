#!/usr/bin/oil
shopt --set xtrace

# 1. Dump all data from the old database version to a single file
podman-compose exec db pg_dumpall -U "miniflux" > dump.sql

# 2. Stop all containers
podman-compose stop

# Backup data volume
podman volume export miniflux_miniflux-db -o db-volume-backup.tar
 
# 3. Remove the data volume
podman volume rm miniflux_miniflux-db

# 5. Start the new container and initialize a blank database instance
podman-compose start db

# 6. Import the dumped file into the database instance
echo dump.sql > podman-compose exec db psql -U "miniflux" -d "miniflux"