{
    config,
    pkgs,
    ...
}: let
    cfgs = [
        "general"
        "env"
        "bindings"
        "autostart"
        "rules"
    ];
    scripts = [
        "boost.fish"
        "screenshot.fish"
        "wallpaper.fish"
    ];
in {
    home.packages = with pkgs; [
        brightnessctl
        jq
        slurp
        wayshot
        wl-clipboard
        matugen
    ];

    services = {
        hyprpaper.enable = true;
        playerctld.enable = true;
    };

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = ''
            $hypr_config_dir = ${config.xdg.configHome}/hypr
            source = $hypr_config_dir/hyprland/colors.conf
            ${builtins.concatStringsSep "\n" (map (f: "source = $hypr_config_dir/hyprland/${f}.conf") cfgs)}
            source = $hypr_config_dir/hyprland/custom.conf
        '';
    };

    writable.xdgConfigFile = {
        "hypr/hyprland/colors.conf".source = ./config/colors.conf;
        "hypr/hyprland/custom.conf".text = "# write custom config here";
    };

    xdg.configFile =
        (builtins.listToAttrs (map (f: {
            name = "hypr/hyprland/${f}.conf";
            value = {
                source = ./config/${f}.conf;
            };
        })
        cfgs))
        // (builtins.listToAttrs (map (f: {
            name = "hypr/hyprland/scripts/${f}";
            value = {
                source = ./scripts/${f};
                executable = true;
            };
        })
        scripts));
}
