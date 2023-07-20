sync-dev:
    watchexec 'rsync -pr -v --exclude .git ./ lily:infrastructure'