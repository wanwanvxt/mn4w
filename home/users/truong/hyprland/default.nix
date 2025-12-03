{ config, pkgs, inputs, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = ''
            $HYPR_CONFIG_DIR = ${config.xdg.configHome}/hypr

            ## GENERAL
            ${builtins.readFile ./config/general.conf}
            ## ENV
            ${builtins.readFile ./config/env.conf}
            ## BINDINGS
            ${builtins.readFile ./config/bindings.conf}
            ## AUTOSTART
            ${builtins.readFile ./config/autostart.conf}
            ## RULES
            ${builtins.readFile ./config/rules.conf}
            ## CUSTOM
            source = $HYPR_CONFIG_DIR/custom.conf
        '';
    };

    writable.xdgConfigFile = {
        "hypr/custom.conf" = {
            text = "";
            override = false;
        };
    };

    # xdg.configFile."hypr/scripts" = {
    #     source = ./scripts;
    #     recursive = true;
    #     executable = true;
    # };
    xdg.configFile = {
        "hypr/scripts/boost.fish" = {
            source = ./scripts/boost.fish;
            executable = true;
        };
        "hypr/scripts/wallpaper.fish" = {
            source = ./scripts/wallpaper.fish;
            executable = true;
        };
        "hypr/scripts/screenshot.fish" = {
            source = ./scripts/screenshot.fish;
            executable = true;
        };
    };

    services.hyprpaper.enable = true;
}
