#!/usr/bin/env fish

set -l wallpaper_dir "$XDG_PICTURES_DIR/wallpapers"
test -d "$wallpaper_dir" || exit 1

set -l all_wallpapers (              \
    find "$wallpaper_dir" -type f \( \
        -iname "*.png"  -o           \
        -iname "*.jpg"  -o           \
        -iname "*.jpeg" -o           \
        -iname "*.jpe"  -o           \
        -iname "*.jxl"  -o           \
        -iname "*.webp"              \
    \)                               \
)
test (count $all_wallpapers) -gt 0 || exit 1

set -l current_wallpaper (           \
    hyprctl hyprpaper listactive     \
    | head -n 1                      \
    | string replace -r '\s*=\s*' '' \
)
set -l new_wallpaper ""
while true
    set new_wallpaper (random choice $all_wallpapers)
    test "$new_wallpaper" != "$current_wallpaper" && break
end

hyprctl -q hyprpaper reload ,"$new_wallpaper"
matugen image -qm dark "$new_wallpaper"
