{ config, lib, ... }:
let
    imvCfg = config.programs.imv;
    imvDesktopPath = "${imvCfg.package}/share/applications/imv.desktop";
    helpers = import ../../helpers.nix lib;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.imv = {
            enable = true;
            settings = {
                options.upscaling_method = "nearest_neighbour";
            };
        };

        xdg.mimeApps.defaultApplications =
            lib.optionalAttrs imvCfg.enable
            (helpers.assignMimesFromDesktop imvDesktopPath [ "imv.desktop" ]);
    };
}
