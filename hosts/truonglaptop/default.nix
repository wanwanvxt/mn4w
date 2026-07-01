{ config, lib, ... }:
let
    networkmanagerCfg = config.networking.networkmanager;
in
{
    imports = [
        ../../shared/truong-btw
        ./hardware-config.nix
    ];

    truong-btw.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.prime = {
        amdgpuBusId = "PCI:5@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
    };

    users.users.truong = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]
            ++ lib.optional networkmanagerCfg.enable "networkmanager";
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.truong = {
            imports = [ ../../shared/truong-btw/home ];
        };
    };
}
