{ config, lib, ... }:
let
    firefoxCfg = config.programs.firefox;
    helpers = import ../../helpers.nix lib;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.firefox.enable = true;

        home.sessionVariables.BROWSER = lib.optionalString firefoxCfg.enable "firefox";
        xdg.mimeApps.defaultApplications =
            lib.optionalAttrs firefoxCfg.enable
            (helpers.assignMimes [
                "x-scheme-handler/http"
                "x-scheme-handler/https"
                "text/html"
                "application/xhtml+xml"
            ] [ "firefox.desktop" ]);
    };
}
