{ config, lib, ... }:
let
    firefoxCfg = config.programs.firefox;
    firefoxDesktopPath = "${firefoxCfg.finalPackage}/share/applications/firefox.desktop";
    helpers = import ./helpers.nix lib;
in
{
    programs.firefox.enable = true;

    home.sessionVariables.BROWSER = "firefox";
    xdg.mimeApps.defaultApplications = helpers.assignMimeFromDesktop firefoxDesktopPath [ "firefox.desktop" ];
}
