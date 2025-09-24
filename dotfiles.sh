#!/usr/bin/env bash

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="$root/dotfiles"
dest_dir="$HOME"

one_time_items=(
    ".config/hypr/hyprland/custom.conf"
    ".config/hypr/monitors.conf"
    ".config/hypr/workspaces.conf"
)

if [[ -d  "$dotfiles_dir" ]]; then
    exclude_opts=()

    for item in "${one_time_items[@]}"; do
        if [[ -e "$dest_dir/$item" ]]; then
            exclude_opts+=(--exclude="$item")
        fi
    done

    rsync_cmd=(rsync -av --progress "${exclude_opts[@]}" "$dotfiles_dir" "$dest_dir")

    echo "Command to be executed:"
    echo -e "\t${rsync_cmd[@]}"

    read -rp "Continue? [y/N] " yesno
    case "$yesno" in
        [Yy]*)
            "${rsync_cmd[@]}"
            ;;
        *)
            echo "Aborted."
            ;;
    esac
    exit
fi

exit 1
