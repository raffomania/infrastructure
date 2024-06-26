#!/usr/bin/ysh
shopt --set xtrace

... sudo pacman --needed -S 
    # base & dev stuff
    base-devel oil git zsh zoxide fzf starship exa neovim man-db
    # network config
    nftables
    # hosting
    podman netavark podman-docker docker-compose aardvark-dns 
    # generating secrets
    pwgen
    # utility
    goaccess pacman-contrib
    ;