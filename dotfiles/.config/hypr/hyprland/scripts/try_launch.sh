#!/usr/bin/env bash

for cmd in "$@"; do
    [[ -z "$cmd" ]] && continue

    exe=${cmd%% *}
    if command -v "$exe" >/dev/null 2>&1; then
        bash -c -- "$cmd" &
        exit 0
    fi
done

exit 1
