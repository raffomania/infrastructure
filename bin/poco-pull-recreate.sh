#!/bin/bash

set -euxo pipefail

podman compose pull
podman compose down 
podman compose up -d
