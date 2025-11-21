{ config, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];

    # graphics
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        prime = {
            sync.enable = true;
            amdgpuBusId = "PCI:5:0:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };

    services.udev.extraRules = ''
        # AMD
        KERNEL=="card*",         \
        KERNELS=="0000:05:00.0", \
        SUBSYSTEM=="drm",        \
        SYMLINK+="dri/amd-igpu"

        # NVIDIA
        KERNEL=="card*",         \
        KERNELS=="0000:01:00.0", \
        SUBSYSTEM=="drm",        \
        SYMLINK+="dri/nvidia-dgpu"
    '';

    environment.variables.AQ_DRM_DEVICES="/dev/dri/amd-igpu:/dev/dri/nvidia-dgpu";

    # locales
    time.timeZone = "Asia/Ho_Chi_Minh";

    # gaming
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
