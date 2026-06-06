{ pkgs, ... }: {
    boot = {
        loader = {
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                useOSProber = true;
                configurationLimit = 20;
                theme = "${pkgs.minimal-grub-theme}";
            };
            efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_zen;
    };
}
