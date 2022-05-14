#!/bin/sh
set -euxo pipefail

passwd root

pacman -S oil git
git clone git@github.com:raffomania/infrastructure