#!/bin/sh

FLAKE_PATH="path:$PWD"
ACTION="${1:-dry}"
HOST="$(hostname)"

case "$ACTION" in
    dry)
        nixos-rebuild dry-activate --flake "$FLAKE_PATH#$HOST" --sudo
        ;;
    boot)
        nixos-rebuild boot --flake "$FLAKE_PATH#$HOST" --sudo
        ;;
    switch)
        nixos-rebuild switch --flake "$FLAKE_PATH#$HOST" --sudo
        ;;
esac
