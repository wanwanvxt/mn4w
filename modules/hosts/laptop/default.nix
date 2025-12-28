{...}: {
    imports = [
        ../../shared/boot.nix
        ../../shared/zram.nix
        ../../shared/gc.nix
        ../../shared/networking.nix
        ../../shared/audio.nix
        ../../shared/bluetooth.nix
        ../../shared/graphics.nix
        ../../shared/gaming.nix
        ../../shared/misc.nix
        ./hardware-configuration.nix
        ./locales.nix
        ./graphics.nix
    ];
}
