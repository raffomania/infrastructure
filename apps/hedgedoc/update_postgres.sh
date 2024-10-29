#!/usr/bin/sh
set -euxo pipefail

cd $(dirname $0)

echo $(pwd)

db_container=hedgedoc-db-1 db_username=hedgedoc db_volume=systemd-hedgedoc-db \
    update-generic-postgres.sh
