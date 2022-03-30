#!/usr/bin/env bash
cd "$FISHNET_SOURCE" || exit
git log --since="yesterday" --no-decorate > "$FISHNET_LOG"
git rev-parse --short HEAD > "$FISHNET_HASH"
