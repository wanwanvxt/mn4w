{ config, pkgs, inputs, ... }:
{
    programs = {
        steam = {
            enable = true;
            localNetworkGameTransfers.openFirewall = true;
            remotePlay.openFirewall = true;
        };
        gamemode = {
            enable = true;
            settings = {
                general = {
                    desiredgov = "performance";
                    softrealtime = "auto";
                    renice = 10;
                    ioprio = 0;
                };
                custom = {
                    start = "notify-send 'GameMode started'";
                    end = "notify-send 'GameMode ended'";
                };
            };
        };
    };
}
