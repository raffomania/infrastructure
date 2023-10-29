#!/bin/sh

set -euxo pipefail

podman secret exists vikunja-jwt-secret || \
    pwgen -s 64 1 | podman secret create vikunja-jwt-secret -

ln -rsf ./*.container ./*.network ./*.volume \
    ~/.config/containers/systemd/

check-quadlet.sh

systemctl --user daemon-reload