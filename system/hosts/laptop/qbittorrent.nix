{ config, pkgs, inputs, ... }:
{
    services.qbittorrent = {
        enable = true;
        torrentingPort = 53490;
        webuiPort = 53491;
        openFirewall = true;
        serverConfig = {
            LegalNotice.Accepted = true;
            Preferences.WebUI.LocalHostAuth = false;
        };
    };
}
