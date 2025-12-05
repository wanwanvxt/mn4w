{ pkgs, ... }:
{
    boot = {
        loader = {
            systemd-boot = {
                enable = true;
                editor = false;
            };
            efi.canTouchEfiVariables = true;
            timeout = 10;
        };
        kernelPackages = pkgs.linuxPackages_latest;
    };
}
