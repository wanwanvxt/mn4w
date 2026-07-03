{ config, lib, ... }:
let
    homeDir = config.home.homeDirectory;
in
{
    config = lib.mkIf config.truong-btw.enable {
        xdg = {
            enable = true;
            localBinInPath = true;
            userDirs = {
                enable = true;
                createDirectories = true;
                desktop     = "${homeDir}/documents";
                documents   = "${homeDir}/documents";
                publicShare = "${homeDir}/documents";
                templates   = "${homeDir}/documents";
                download    = "${homeDir}/downloads";
                music       = "${homeDir}/music";
                pictures    = "${homeDir}/pictures";
                videos      = "${homeDir}/videos";
                projects    = "${homeDir}/projects";
            };

            mimeApps.enable = true;
        };
    };
}
