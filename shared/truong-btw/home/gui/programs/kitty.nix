{ config, lib, ... }:
let
    gtkCfg = config.gtk;
    xdgTermExecCfg = config.xdg.terminal-exec;
    kittyCfg = config.programs.kitty;
    helpers = import ../../helpers.nix lib;

    dconfTermSettings = {
        exec = lib.optionalString xdgTermExecCfg.enable "xdg-terminal-exec";
        exec-arg = lib.optionalString xdgTermExecCfg.enable "--";
    };
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.kitty = {
            enable = true;
            settings = {
                font_family = "monospace";
                font_size = if gtkCfg.enable then (gtkCfg.font.size or 12) else 12;
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
            settings.default = lib.optional kittyCfg.enable "kitty.desktop";
        };

        home.sessionVariables.TERMINAL = lib.optionalString kittyCfg.enable "kitty";
        xdg.mimeApps.defaultApplications =
            lib.optionalAttrs kittyCfg.enable
            (helpers.assignMimes "x-scheme-handler/terminal" [ "kitty.desktop" ]);

        dconf.settings = {
            "org/gnome/desktop/default-applications/terminal" = dconfTermSettings;
            "org/cinnamon/desktop/default-applications/terminal" = dconfTermSettings;
            "org/gnome/desktop/applications/terminal" = dconfTermSettings;
            "org/cinnamon/desktop/applications/terminal" = dconfTermSettings;
        };
    };
}
