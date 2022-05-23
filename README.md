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
pass wg/<host>.key | ssh -p 22 root@lily "cat > <host>.key"
scp -P 22 bin/bootstrap.sh root@<host>:
ssh -p 22 root@<host>
./bootstrap.sh
```

- log out and log in again using `ssh <host>` to switch to zsh and management user

## TODO

- backups
- automatic updates
- restrict access to vpn
- disallow root SSH login