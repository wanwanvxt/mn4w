#!/usr/bin/env bash

gnome_schema="org.gnome.desktop.interface"
gtk_config="$HOME/.config/gtk-4.0/settings.ini"
[[ ! -f "$gtk_config" ]] && gtk_config="$HOME/.config/gtk-3.0/settings.ini"
[[ ! -f "$gtk_config" ]] && exit 1

gtk_theme="$(grep 'gtk-theme-name' "$gtk_config" | sed 's/.*\s*=\s*//')"
prefer_dark_theme="$(grep 'gtk-application-prefer-dark-theme' "$gtk_config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$gtk_config" | sed 's/.*\s*=\s*//')"
cursor_size="$(grep 'gtk-cursor-theme-size' "$gtk_config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$gtk_config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$gtk_config" | sed 's/.*\s*=\s*//')"

# echo "gtk_theme: $gtk_theme"
# echo "prefer_dark_theme: $prefer_dark_theme"
# echo "cursor_theme: $cursor_theme"
# echo "cursor_size: $cursor_size"
# echo "font_name: $font_name"
# echo "icon_theme: $icon_theme"

if [[ $prefer_dark_theme == "true" ]]; then
    color_scheme="prefer-dark"
else
    color_scheme="prefer-light"
fi
echo "color_scheme: $color_scheme"

gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
gsettings set "$gnome_schema" color-scheme "$color_scheme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" cursor-size "$cursor_size"
gsettings set "$gnome_schema" font-name "$font_name"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
