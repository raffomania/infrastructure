#!/usr/bin/oil
shopt --set xtrace

... sudo pacman --needed -S 
    # base & dev stuff
    base-devel oil git zsh zoxide fzf starship exa neovim man-db
    # network config
    wireguard-tools nftables
    # hosting
    podman
    ;