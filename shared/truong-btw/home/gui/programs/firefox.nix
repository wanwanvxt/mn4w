{ config, lib, ... }:
let
    helpers = import ../../helpers.nix lib;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.firefox.enable = true;

        home.sessionVariables.BROWSER = "firefox";
        xdg.mimeApps.defaultApplications = helpers.assignMimes [
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "text/html"
            "application/xhtml+xml"
        ] [ "firefox.desktop" ];
    };
}
