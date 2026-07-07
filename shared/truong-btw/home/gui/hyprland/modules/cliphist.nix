{ config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
    config = lib.mkIf config.truong-btw.enable {
        services.cliphist = {
            enable = hyprlandCfg.enable;
            allowImages = true;
            extraOptions = [];
        };
    };
}
