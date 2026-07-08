{ config, lib, ... }:
let
    homeDir = config.home.homeDirectory;
    xdgTermExecCfg = config.xdg.terminal-exec;
    dconfTermSettings = {
        exec =
            if xdgTermExecCfg.enable then (lib.getExe xdgTermExecCfg.package)
            else (config.home.sessionVariables.TERMINAL or "");
        exec-arg = "--";
    };
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
            terminal-exec.enable = true;
        };

        dconf.settings = {
            "org/gnome/desktop/default-applications/terminal" = dconfTermSettings;
            "org/cinnamon/desktop/default-applications/terminal" = dconfTermSettings;
            "org/gnome/desktop/applications/terminal" = dconfTermSettings;
            "org/cinnamon/desktop/applications/terminal" = dconfTermSettings;
        };
    };
}
