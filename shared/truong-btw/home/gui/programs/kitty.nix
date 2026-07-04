{ config, lib, ... }:
let
    gtkCfg = config.gtk;
    helpers = import ../../helpers.nix lib;

    dconfTermSettings = {
        exec = "xdg-terminal-exec";
        exec-arg = "--";
    };
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.kitty = {
            enable = true;
            settings = {
                font_family = "monospace";
                font_size = gtkCfg.font.size or 12;
                remember_window_size = false;
                background_opacity = 0.8;
                background_blur = 1;
            };
            keybindings = {
                page_up = "scroll_page_up";
                page_down = "scroll_page_down";
            };
        };

        xdg.terminal-exec = {
            enable = true;
            settings.default = [ "kitty.desktop" ];
        };

        home.sessionVariables.TERMINAL = "kitty";
        xdg.mimeApps.defaultApplications = helpers.assignMimes "x-scheme-handler/terminal" [ "kitty.desktop" ];

        dconf.settings = {
            "org/gnome/desktop/default-applications/terminal" = dconfTermSettings;
            "org/cinnamon/desktop/default-applications/terminal" = dconfTermSettings;
        };
    };
}
