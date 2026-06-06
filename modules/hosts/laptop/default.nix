{
    imports = [
        ../../shared/truong-btw
        ./hardware-config.nix
    ];

    hardware.cpu.amd.updateMicrocode = true;

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.prime = {
        amdgpuBusId = "PCI:5@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
    };
}
