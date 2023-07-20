#!/usr/bin/ysh
shopt --set xtrace

... sudo pacman --needed -S 
    # base & dev stuff
    base-devel oil git zsh zoxide fzf starship exa neovim man-db
    # network config
    tailscale nftables
    # hosting
    podman podman-compose aardvark-dns
    ;