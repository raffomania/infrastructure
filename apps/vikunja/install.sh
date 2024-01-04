#!/bin/sh

echo "The vikunja setup is currently archived. Before continuing, please update to the newest version, remove existing volumes and containers if applicable, and then remove this line from the install script."
exit

set -euxo pipefail

podman secret exists vikunja-jwt-secret || \
    pwgen -s 64 1 | podman secret create vikunja-jwt-secret -

ln -rsf ./*.container ./*.network ./*.volume \
    ~/.config/containers/systemd/

check-quadlet.sh

systemctl --user daemon-reload