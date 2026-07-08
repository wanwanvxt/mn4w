{ osConfig, config, lib, ... }:
let
    uwsmSysCfg = osConfig.programs.uwsm;
in
{
    config = lib.mkIf config.truong-btw.enable {
        xdg.configFile = lib.optionalAttrs uwsmSysCfg.enable {
            "uwsm/default-id".text = "hyprland-uwsm.desktop";

            "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
            "uwsm/env.d/10-wl.conf".text = ''
                export GDK_BACKEND=wayland,x11,*
                export CLUTTER_BACKEND=wayland
                export QT_QPA_PLATFORM=wayland;xcb
                export ELECTRON_OZONE_PLATFORM_HINT=auto
                export PROTON_ENABLE_WAYLAND=1
                export SDL_VIDEODRIVER=wayland
                export SDL_VIDEO_DRIVER=wayland

                export QT_AUTO_SCREEN_SCALE_FACTOR=1
            '';
            "uwsm/env-hyprland".text = ''
                export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            '';
        };
    };
}
