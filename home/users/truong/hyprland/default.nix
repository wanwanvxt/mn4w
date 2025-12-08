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
    programs = {
        kitty.enable = true;
        firefox.enable = true;
        btop.enable = true;
    };

    home.packages = with pkgs; [
        kdePackages.dolphin
        nvtopPackages.full
        brightnessctl
        jq
        wl-clipboard
        slurp
        wayshot
    ];

    services = {
        hyprpaper.enable = true;
        playerctld.enable = true;
    };

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = ''
            $HYPR_CONFIG_PATH = ${config.xdg.configHome}/hypr
            source = $HYPR_CONFIG_PATH/hyprland/colors.conf
            ${
                builtins.concatStringsSep "\n" (builtins.map (f: "source = $HYPR_CONFIG_PATH/hyprland/${f}") readonlyCfgFiles)
            }
            source = $HYPR_CONFIG_PATH/hyprland/custom.conf
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
