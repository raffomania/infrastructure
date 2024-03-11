#!/bin/sh

set -euxo pipefail

ln -rsf ./*.container ./*.network ./*.volume \
    ~/.config/containers/systemd/

check-quadlet.sh

systemctl --user daemon-reload