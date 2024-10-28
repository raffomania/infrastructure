#!/bin/sh
set -euxo pipefail

test -f ./session-secret || \
    echo $(pwgen -s 64 1) > session-secret
