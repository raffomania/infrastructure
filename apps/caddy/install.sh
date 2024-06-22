#!/bin/sh
set -euxo pipefail

test -f ./guest-password-hash-secret \
    || password="" && read -p "Please enter guest password:" password \
    && podman compose run caddy caddy hash-password -p "$password"  \
        > ./guest-password-hash-secret
