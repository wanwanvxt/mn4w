{ config, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = ''
            $HYPR_CONFIG_PATH = ${config.xdg.configHome}/hypr

            source = $HYPR_CONFIG_PATH/hyprland/colors.conf
            source = $HYPR_CONFIG_PATH/hyprland/general.conf
            source = $HYPR_CONFIG_PATH/hyprland/env.conf
            source = $HYPR_CONFIG_PATH/hyprland/bindings.conf
            source = $HYPR_CONFIG_PATH/hyprland/autostart.conf
            source = $HYPR_CONFIG_PATH/hyprland/rules.conf
            source = $HYPR_CONFIG_PATH/hyprland/custom.conf
        '';
    };

    writable.xdgConfigFile = {
        "hypr/hyprland/colors.conf".source = ./config/colors.conf;
        "hypr/hyprland/custom.conf".source = ./config/custom.conf;
    };

    xdg.configFile = {
        "hypr/hyprland/general.conf".source = ./config/general.conf;
        "hypr/hyprland/env.conf".source = ./config/env.conf;
        "hypr/hyprland/bindings.conf".source = ./config/bindings.conf;
        "hypr/hyprland/autostart.conf".source = ./config/autostart.conf;
        "hypr/hyprland/rules.conf".source = ./config/rules.conf;

        "hypr/hyprland/scripts/boost.fish" = {
            source = ./scripts/boost.fish;
            executable = true;
        };
        "hypr/hyprland/scripts/wallpaper.fish" = {
            source = ./scripts/wallpaper.fish;
            executable = true;
        };
        "hypr/hyprland/scripts/screenshot.fish" = {
            source = ./scripts/screenshot.fish;
            executable = true;
        };
    };

    services.hyprpaper.enable = true;
}
