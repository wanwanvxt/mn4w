{ pkgs, config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    xdgUserDirsCfg = config.xdg.userDirs;

    pkgGrim = pkgs.symlinkJoin {
        name = "grim-with-sound";
        paths = [ pkgs.grim ];

        nativeBuildInputs = [ pkgs.makeWrapper ];

        postBuild = ''
            wrapProgram $out/bin/grim \
                --run "${lib.getExe pkgs.libcanberra-gtk3} -i camera-shutter &"
        '';
    };
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.hyprshot = {
            enable = hyprlandCfg.enable;
            package = pkgs.hyprshot.override {
                grim = pkgGrim;
            };
            saveLocation = "${
                if xdgUserDirsCfg.enable
                then xdgUserDirsCfg.pictures
                else "~"
            }/screenshots";
        };
    };
}
