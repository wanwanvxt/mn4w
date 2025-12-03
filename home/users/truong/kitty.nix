{ config, pkgs, inputs, ... }:
{
    programs.kitty = {
        enable = true;
        settings = {
            font_family = "0xProto Nerd Font";
            font_size = 10;
            remember_window_size = false;
            background_opacity = 0.75;
            background_blur = 1;
            shell = "fish";
        };
        keybindings = {
            "page_up" = "scroll_page_up";
            "page_down" = "scroll_page_down";
        };
    };

    xdg.terminal-exec = {
        enable = true;
        settings = {
            default = [ "kitty.desktop" ];
        };
    };

    qt.kde.settings.kdeglobals.General.TerminalApplication = "kitty";
}
