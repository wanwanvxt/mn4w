{ config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    xdgUserDirsCfg = config.xdg.userDirs;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.hyprshot = {
            enable = hyprlandCfg.enable;
            saveLocation = "${
                if xdgUserDirsCfg.enable
                then xdgUserDirsCfg.pictures
                else "~"
            }/screenshots";
        };
    };
}
