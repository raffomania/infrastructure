#!/bin/sh
set -euxo pipefail

test -f ./secret-key.env || \
    echo "SECRET_KEY=$(openssl rand -hex 32)" > secret-key.env

test -f ./utils-secret.env || \
    echo "UTILS_SECRET=$(openssl rand -hex 32)" > utils-secret.env

test -f ./manual-secrets.env || \
    echo "Please create manual-secrets.env." && exit 1
