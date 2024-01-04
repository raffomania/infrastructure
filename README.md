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
poco pull
poco down
poco up -d
podman system prune -a
```

For quadlet-based setups, you can usually do 

```sh
systemctl --user daemon-reload
systemctl --user restart <container>
```

To prevent downtime while podman is pulling the image, manually issue a `podman pull <container>:<tag>` command before issuing the restart.

## TODO

- podman volume backups 
- automated migration of backups to new server
- restrict access to vpn
- use podman secrets for db passwords etc