{...}: {
    imports = [
        ../../shared/boot.nix
        ../../shared/nix.nix
        ../../shared/networking.nix
        ../../shared/audio.nix
        ../../shared/bluetooth.nix
        ../../shared/graphics.nix
        ../../shared/gaming.nix
        ./hardware-configuration.nix
        ./locales.nix
        ./graphics.nix
        ./misc.nix
        ../../users/truong
    ];
}
