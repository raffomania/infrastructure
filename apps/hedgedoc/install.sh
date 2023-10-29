#!/bin/sh

set -euxo pipefail

podman secret exists hedgedoc-session-secret || \
    pwgen -s 64 1 | podman secret create hedgedoc-session-secret -

podman secret exists hedgedoc-db-password || \
    pwgen -s 64 1 | podman secret create hedgedoc-db-password -

ln -rsf ./*.container ./*.network ./*.volume \
    ~/.config/containers/systemd/

check-quadlet.sh

systemctl --user daemon-reload