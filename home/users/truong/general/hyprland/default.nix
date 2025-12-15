{
    config,
    pkgs,
    lib,
    ...
}: let
    readonlyCfgFiles = [
        "general.conf"
        "env.conf"
        "bindings.conf"
        "autostart.conf"
        "rules.conf"
    ];
    scriptFiles = [
        "boost.fish"
        "screenshot.fish"
        "wallpaper.fish"
    ];

    mkEntries = files: dir: executable:
        lib.genAttrs files (f: {
            source = ./${dir}/${f};
            inherit executable;
        });
in {
    home.packages = with pkgs; [
        brightnessctl
        jq
        slurp
        wayshot
        wl-clipboard
    ];

    services = {
        hyprpaper.enable = true;
        playerctld.enable = true;
    };

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = ''
            $HYPR_CONFIG_DIR = ${config.xdg.configHome}/hypr
            source = $HYPR_CONFIG_DIR/hyprland/colors.conf
            ${
                builtins.concatStringsSep "\n" (builtins.map (f: "source = $HYPR_CONFIG_DIR/hyprland/${f}") readonlyCfgFiles)
            }
            source = $HYPR_CONFIG_DIR/hyprland/custom.conf
        '';
    };

    writable.xdgConfigFile = {
        "hypr/hyprland/colors.conf".source = ./config/colors.conf;
        "hypr/hyprland/custom.conf".source = ./config/custom.conf;
    };

    xdg.configFile =
        (lib.mapAttrs' (name: value: (lib.nameValuePair "hypr/hyprland/${name}" value)) (mkEntries readonlyCfgFiles "./config" false))
        // (lib.mapAttrs' (name: value: (lib.nameValuePair "hypr/hyprland/scripts/${name}" value)) (mkEntries scriptFiles "./scripts" true));
}
