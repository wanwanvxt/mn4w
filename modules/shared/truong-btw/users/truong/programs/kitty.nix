{ lib, ... }:
let
    kittyMimes = [
        "x-scheme-handler/terminal"
        "application/x-shellscript"
        "application/x-sh"
    ];
    helpers = import ./helpers.nix lib;
in
{
    programs.kitty = {
        enable = true;
        settings = {
            font_family = "monospace";
            font_size = 12;
            remember_window_size = false;
            background_opacity = 0.8;
            background_blur = 1;
        };
        keybindings = {
            page_up = "scroll_page_up";
            page_down = "scroll_page_down";
        };
        extraConfig = ''
            include colors.conf
        '';
    };

    xdg.terminal-exec = {
        enable = true;
        settings.default = [ "kitty.desktop" ];
    };
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "kitty";

    home.sessionVariables.TERMINAL = "kitty";
    systemd.user.sessionVariables.TERMINAL = "kitty";

    xdg.mimeApps.defaultApplications = helpers.assignMime kittyMimes [ "kitty.desktop" ];
}
