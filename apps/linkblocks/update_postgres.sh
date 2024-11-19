#!/usr/bin/sh
set -euxo pipefail

cd $(dirname $0)

db_container=linkblocks-db-1 db_username=linkblocks db_volume=systemd-linkblocks-postgres \
    update-generic-postgres.sh
