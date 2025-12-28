{
    config,
    pkgs,
    ...
}: let
    cfgs = builtins.attrNames (builtins.readDir ./configs);
    scripts = builtins.attrNames (builtins.readDir ./scripts);
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
        systemd = {
            enable = true;
            variables = ["--all"];
        };
        extraConfig = ''
            $hypr_config_dir = ${config.xdg.configHome}/hypr
            source = $hypr_config_dir/hyprland/colors.conf
            ${builtins.concatStringsSep "\n" (map (f: "source = $hypr_config_dir/hyprland/${f}") cfgs)}
            source = $hypr_config_dir/hyprland/custom.conf
        '';
    };

    writable.xdgConfigFile = {
        "hypr/hyprland/colors.conf".text = builtins.concatStringsSep "\n" [
            "$hypr_col_outline_active = rgb(00ff99)"
            "$hypr_col_outline_inactive = rgb(808080)"
            "$hypr_col_shadow = rgb(000000)"
            "$hypr_col_background = rgb(000000)"
        ];
        "hypr/hyprland/custom.conf".text = "# write custom config here";
    };

    xdg.configFile =
        (builtins.listToAttrs (map (f: {
            name = "hypr/hyprland/${f}";
            value = {
                source = ./configs/${f};
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
