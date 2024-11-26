#!/bin/sh
set -euxo pipefail

test -f ./guest-password-hash-secret \
    || (password="" && read -p "Please enter guest password:" password \
    && podman compose run --rm caddy caddy hash-password -p "$password"  \
        > ./guest-password-hash-secret)

test -f ./private-password-hash-secret \
    || (password="" && read -p "Please enter private password:" password \
    && podman compose run --rm caddy caddy hash-password -p "$password"  \
        > ./private-password-hash-secret)
