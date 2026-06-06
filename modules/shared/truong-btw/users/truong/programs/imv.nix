{ config, lib, ... }:
let
    imvCfg = config.programs.imv;
    imvDesktopPath = "${imvCfg.package}/share/applications/imv.desktop";
    helpers = import ./helpers.nix lib;
in
{
    programs.imv = {
        enable = true;
        settings = {
            options.upscaling_method = "nearest_neighbour";
        };
    };

    xdg.mimeApps.defaultApplications = helpers.assignMimeFromDesktop imvDesktopPath [ "imv.desktop" ];
}
