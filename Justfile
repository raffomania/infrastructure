sync-dev host:
    watchexec 'rsync -pr -v --delete ./ {{host}}:infrastructure'