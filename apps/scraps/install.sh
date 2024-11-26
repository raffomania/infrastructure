#!/bin/sh
set -euxo pipefail

test -f ./secret-key.env || 
    echo "SECRET_KEY_BASE=$(pwgen 64)" > secret-key.env

podman compose run --rm scraps /app/bin/migrate
