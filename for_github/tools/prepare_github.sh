#!/usr/bin/env bash
set -euo pipefail

DEST="for_github"
rm -rf "$DEST"
mkdir -p "$DEST"

# Use rsync if available, otherwise use tar fallback
if command -v rsync >/dev/null 2>&1; then
    rsync -av --exclude='secrets' \
        --exclude='.env' \
        --exclude='srcs/requirements/nginx/conf/nginx.key' \
        --exclude='srcs/requirements/nginx/conf/nginx.crt' \
        --exclude='**/*.key' \
        --exclude='**/*.pem' \
        --exclude='**/*.crt' \
        --exclude='for_github' \
        . "$DEST/"
else
    # Tar fallback: create an archive excluding patterns and extract into dest
    TAR_EXCLUDES=(
        --exclude=secrets
        --exclude=.env
        --exclude=srcs/requirements/nginx/conf/nginx.key
        --exclude=srcs/requirements/nginx/conf/nginx.crt
        --exclude=*.key
        --exclude=*.pem
        --exclude=*.crt
        --exclude=for_github
    )
    (tar "${TAR_EXCLUDES[@]}" -cf - .) | (cd "$DEST" && tar -xpf -)
fi

# Remove any leftover docker or git state if present
rm -rf "$DEST/.git" || true
rm -rf "$DEST/.docker" || true

echo "Prepared $DEST (keys and secrets excluded)." > "$DEST/README_GITHUB_COPY.txt"

echo "Done. Files are in $DEST/" 
