{ config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        programs = {
            steam = {
                enable = true;
                localNetworkGameTransfers.openFirewall = true;
                remotePlay.openFirewall = true;
                dedicatedServer.openFirewall = true;
            };

            gamescope = {
                enable = true;
                capSysNice = true;
            };

            gamemode = {
                enable = true;
                enableRenice = true;
                settings = {
                    general = {
                        reaper_freq = 5;
                        desiredgov = "performance";
                        desiredprof = "performance";

                        igpu_desiredgov = "powersave";
                        igpu_power_threshold = 0.3;

                        renice = 10;
                        ioprio = 0;
                    };
                };
            };
        };

        zramSwap = {
            enable = true;
            priority = 100;
            algorithm = "zstd";
            memoryPercent = 50;
            memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
        };
    };
}
