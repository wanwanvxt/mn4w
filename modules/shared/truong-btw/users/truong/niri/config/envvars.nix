{ config, lib, ... }:
let
    niriCfg = config.programs.niri;
in
{
    config = lib.mkIf niriCfg.enable {
        xdg.configFile."niri/config/envvars.kdl".text = ''
            environment {
                // wayland
                GDK_BACKEND                  "wayland,x11,*"
                CLUTTER_BACKEND              "wayland"
                QT_QPA_PLATFORM              "wayland;xcb"
                ELECTRON_OZONE_PLATFORM_HINT "auto"
                SDL_VIDEODRIVER              "wayland"
                SDL_VIDEO_DRIVER             "wayland"
                // PROTON_ENABLE_WAYLAND        "1"

                // qt
                QT_AUTO_SCREEN_SCALE_FACTOR         "1"
                QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
            }
        '';
    };
}
