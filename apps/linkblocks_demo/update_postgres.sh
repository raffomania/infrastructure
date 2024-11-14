#!/usr/bin/sh
set -euxo pipefail

cd $(dirname $0)

db_container=linkblocks_demo-db-1 db_username=linkblocks db_volume=systemd-linkblocks-demo-postgres \
    update-generic-postgres.sh
