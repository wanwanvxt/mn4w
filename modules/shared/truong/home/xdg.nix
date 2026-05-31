{ pkgs, config, ... }:
let
    homeDir = config.home.homeDirectory;
in
{
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
            download    = "${homeDir}/download";
            music       = "${homeDir}/music";
            pictures    = "${homeDir}/pictures";
            videos      = "${homeDir}/videos";
            projects    = "${homeDir}/projects";
        };

        mimeApps.enable = true;
    };

    home.packages = [ pkgs.xdg-utils ];
}
