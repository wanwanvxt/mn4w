{ pkgs, config, lib, ... }:
let
    mpvCfg = config.programs.mpv;
    desktopPath = "${mpvCfg.package}/share/applications/mpv.desktop";
    helpers = import ../../helpers.nix lib;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.mpv = {
            enable = true;
            package = (pkgs.mpv.override {
                scripts = with pkgs.mpvScripts; [
                    modernz
                    autoload
                    thumbfast
                    mpris
                ];
            });
            config = {
                keep-open = true;
                save-position-on-quit = true;
                save-watch-history = true;
            };
        };

        xdg.mimeApps.defaultApplications =
            helpers.assignMimesFromDesktop desktopPath [ "mpv.desktop" ];
    };
}
