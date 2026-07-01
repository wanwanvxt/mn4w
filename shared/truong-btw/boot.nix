{ pkgs, config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        boot = {
            loader = {
                grub = {
                    enable = true;
                    device = "nodev";
                    efiSupport = true;
                    useOSProber = true;
                    configurationLimit = 20;
                    splashImage = null;
                    theme = "${pkgs.minimal-grub-theme}";
                };
                efi.canTouchEfiVariables = true;
            };

            kernelPackages = pkgs.linuxPackages_zen;
        };

        hardware.enableAllFirmware = true;
    };
}
