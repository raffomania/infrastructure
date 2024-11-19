# Infrastructure

## bootstrapping a hetzner cloud server

- boot into rescue mode using web interface

```sh
ssh <host>
installimage
```

- select arch linux
- configure hostname
- save config and let the installer install
- `reboot`
- remove server from known hosts

```sh
scp -P 22 bin/bootstrap.sh root@<host>:
ssh -p 22 root@<host>
./bootstrap.sh
```

- log out and log in again using `ssh <host>` to switch to zsh and management user

## Running apps

Usually it's just a `podman-compose up -d`.

Errors regarding containers that already exist can be ignored, AFAIK.

## Updating apps

The renovate bot should update versions in `docker-compose.yml` and open a PR. Some apps might have custom update scripts (like postgres), but usually you can just do this after merging:

```sh
cd infrastructure/apps/<app>
poco-pull-recreate.sh
```

For linkblocks and other containers using the latest tag, do
```
podman pull ghcr.io/raffomania/linkblocks:latest
```

Remember to restart the specific container that was updated. For a postgres update, you might restart e.g. `<container>-postgres`.

To prevent downtime while podman is pulling the image, manually issue a `podman pull <container>:<tag>` command before issuing the restart.

## Freeing disk space

```
podman system prune -a
# Remove all cached packages except the
# two most recently installed version
sudo paccache -rk2
# Remove all cached packages that were uninstalled
sudo paccache -ruk0
```

## TODO

- podman volume backups 
- automated migration of backups to new server
- restrict access to vpn
- use podman secrets for db passwords etc

## Archived Apps

These are available in git history:

- vikunja
