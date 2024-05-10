#!/usr/bin/sh
set -euxo pipefail

systemctl --user stop hedgedoc

# Dump all data from the old database version to a single file
podman exec hedgedoc-postgres pg_dumpall -U "hedgedoc" > dump.sql

# Stop db container
systemctl --user stop hedgedoc-postgres

# Backup data volume
podman volume export systemd-hedgedoc-db -o ~/backups/hedgedoc-db-volume-backup.tar

# remove db volume
podman volume rm systemd-hedgedoc-db
 
# Start the new container and initialize a blank database instance
systemctl --user daemon-reload
systemctl --user start hedgedoc-postgres

# Wait for db to start
sleep 5

# Import the dumped file into the database instance
podman exec -i hedgedoc-postgres sh -c 'psql -U "hedgedoc" -d "hedgedoc"' < dump.sql

# re-start the rest
systemctl --user start hedgedoc

echo "check if everything works, then remove dump.sql and ~/backups/hedgedoc-db-volume-backup.tar"