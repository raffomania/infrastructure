#!/usr/bin/sh
set -euxo pipefail

# Stop all containers
podman compose stop

# Backup data volume
podman volume export actual_data -o ~/backups/$(date +%F)-actual-data-backup.tar

# Start up again
podman compose up -d
