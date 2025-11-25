#!/usr/bin/env fish

set -l screenshots_dir "$XDG_PICTURES_DIR/screenshots"
test -d "$screenshots_dir" || mkdir -p "$screenshots_dir"

set -l file_name (date +'%Y-%m-%d-%H%M%S.png')
set -l file_path "$screenshots_dir/$file_name"

function copy2clipboard
    set -l file_to_copy $argv[1]
    test -f "$file_to_copy" && wl-copy <"$file_to_copy"
end

function opts
    fish_opt -s m -l mode --required-val
end
argparse (opts) -- $argv

set -q _flag_mode || exit 1

set -l mode (echo $_flag_mode | tr '[:upper:]' '[:lower:]')
switch $mode
    case screen
        wayshot -f "$file_path"
        test $status -eq 0 && copy2clipboard "$file_path"
        exit 0
    case window
        set -l box (hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        wayshot -s "$box" -f "$file_path"
        test $status -eq 0 && copy2clipboard "$file_path"
        exit 0
    case area
        wayshot -s (slurp -d) -f "$file_path"
        test $status -eq 0 && copy2clipboard "$file_path"
        exit 0
    case "*"
        exit 1
end
