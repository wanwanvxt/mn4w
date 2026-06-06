{ pkgs, config, lib, ... }:
let
    mpvCfg = config.programs.mpv;
    desktopPath = "${mpvCfg.package}/share/applications/mpv.desktop";
    helpers = import ./helpers.nix lib;
in
{
    programs.mpv = {
        enable = true;
        package = (pkgs.mpv.override {
            scripts = with pkgs.mpvScripts; [
                uosc
                thumbfast
            ];
        });
        config = {
            save-position-on-quit = true;
            save-watch-history = true;
        };
    };

    xdg.mimeApps.defaultApplications = helpers.assignMimeFromDesktop desktopPath [ "mpv.desktop" ];
}
