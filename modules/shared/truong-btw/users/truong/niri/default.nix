{ pkgs, config, osConfig, lib, ... }:
let
    niriCfg = config.programs.niri;
    uwsmCfg = osConfig.programs.uwsm;
    xdgUserPicturesDir = config.xdg.userDirs.pictures or "~/pictures";
in
{
    # some modules require checking niri is already installed
    options.programs.niri.enable = lib.mkEnableOption "";

    config = lib.mkMerge [
        { programs.niri.enable = true; }

        (lib.mkIf niriCfg.enable {
            home.packages = with pkgs; [
                niri
                xwayland-satellite

                (writeScriptBin "start-niri" ''
                    if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] &&
                        ! pgrep -u "$USER" -x niri >/dev/null 2>&1 &&
                        ${if uwsmCfg.enable then "uwsm check may-start" else "true"}
                    then
                        exec ${lib.optionalString uwsmCfg.enable "uwsm start --"} niri --session
                    else
                        echo "Failed to start Niri session!"
                        sleep 5
                    fi
                '')

                brightnessctl
                playerctl
            ];

            xdg.portal = {
                enable = true;
                xdgOpenUsePortal = true;
                config.niri.default = [ "gtk" "wlr" ];
                extraPortals = with pkgs; [
                    xdg-desktop-portal-gtk
                    xdg-desktop-portal-wlr
                ];
            };

            xdg.configFile = {
                "niri/config.kdl".text = ''
                    screenshot-path "${xdgUserPicturesDir}/screenshot/Screenshot %Y-%m-%d_%H%M%S.png"

                    include "my/config/general.kdl"
                    include "my/config/bindings.kdl"
                    include "my/config/rules.kdl"
                    ${lib.optionalString (!uwsmCfg.enable) "include \"my/envvars.kdl\""}

                    include optional=true "colors.kdl"
                    include optional=true "custom.kdl"
                '';
                "niri/my/config".source = ./config;
            } //
            (builtins.listToAttrs (map (f: {
                name = "niri/my/scripts/${f}";
                value = {
                    executable = true;
                    source = ./scripts/${f};
                };
            }) [ "spawn" ]));
        })

        (lib.mkIf (niriCfg.enable && uwsmCfg.enable) {
            xdg.configFile = {
                "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
                "uwsm/env.d/10-wl.conf".text = ''
                    export GDK_BACKEND='wayland,x11,*'
                    export CLUTTER_BACKEND=wayland
                    export QT_QPA_PLATFORM='wayland;xcb'
                    export ELECTRON_OZONE_PLATFORM_HINT=auto
                    export SDL_VIDEODRIVER=wayland
                    export SDL_VIDEO_DRIVER=wayland

                    export QT_AUTO_SCREEN_SCALE_FACTOR=1
                    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
                '';
            };
        })
    ];
}
