{ config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    xdgCfg = config.xdg;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.hyprshot = {
            enable = hyprlandCfg.enable;
            saveLocation = "${xdgCfg.userDirs.pictures or "~"}/screenshots";
        };
    };
}
