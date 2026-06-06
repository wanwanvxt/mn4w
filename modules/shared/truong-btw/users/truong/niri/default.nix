{ pkgs, config, osConfig, lib, ... }:
let
    niriCfg = config.programs.niri;
    uwsmCfg = osConfig.programs.uwsm;
in
{
    # some modules require checking niri is already installed
    options.programs.niri.enable = lib.mkEnableOption "";

    imports = [
        ./config/general.nix
        ./config/rules.nix
        ./config/bindings.nix
        ./config/envvars.nix
        ./scripts/spawn.nix
    ];

    config = lib.mkMerge [
        { programs.niri.enable = true; }

        (lib.mkIf niriCfg.enable {
            home.packages = [ pkgs.niri ];

            xdg.portal = {
                enable = true;
                xdgOpenUsePortal = true;
                config.niri.default = [ "gtk" "wlr" ];
                extraPortals = with pkgs; [
                    xdg-desktop-portal-gtk
                    xdg-desktop-portal-wlr
                ];
            };

            xdg.configFile."niri/config.kdl".text = ''
                include "config/general.kdl"
                include "config/bindings.kdl"
                include "config/rules.kdl"
                ${lib.optionalString (!uwsmCfg.enable) ''include "envvars.kdl"''}

                include optional=true "colors.kdl"
                include optional=true "local.kdl"
            '';
        })

        (lib.mkIf (niriCfg.enable && uwsmCfg.enable) {
            xdg.configFile = {
                "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
                "uwsm/env.d/10-wl.conf".text = ''
                    export GDK_BACKEND=wayland,x11,*
                    export CLUTTER_BACKEND=wayland
                    export QT_QPA_PLATFORM=wayland;xcb
                    export ELECTRON_OZONE_PLATFORM_HINT=auto
                    export SDL_VIDEODRIVER=wayland
                    export SDL_VIDEO_DRIVER=wayland

                    export QT_AUTO_SCREEN_SCALE_FACTOR=1
                    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
                '';

                "uwsm/default-id".text = "niri.desktop";
            };
        })
    ];
}
