sync-dev:
    watchexec 'rsync -pr -v --delete --exclude .git ./ lily:infrastructure'