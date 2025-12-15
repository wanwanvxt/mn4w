#!/usr/bin/env fish

set hypr_anim_enabled (hyprctl -j getoption animations:enabled | jq ".int")

if test "$hypr_anim_enabled" -eq 1
    hyprctl -q --batch "
        keyword general:gaps_in 0;
        keyword general:gaps_out 0;
        keyword general:border_size 1;
        keyword decoration:rounding 0;
        keyword decoration:shadow:enabled 0;
        keyword decoration:blur:enabled 0;
        keyword animations:enabled 0"
else
    hyprctl -q reload
end
