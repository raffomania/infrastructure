#!/bin/sh

set -euxo pipefail

# Check that quadlet runs successfully, exit with error if not
/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun 1>/dev/null