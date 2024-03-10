#!/bin/bash

set -euxo pipefail

podman pull ghcr.io/raffomania/linkblocks:latest

systemctl --user daemon-reload
systemctl --user restart linkblocks-demo