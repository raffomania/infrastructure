# Infrastructure

## bootstrapping a hetzner cloud server

- boot into rescue mode

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
rsync -a bin/bootstrap.sh <host>:
ssh <host>
./bootstrap.sh
```

- log out and log in again to switch to zsh
