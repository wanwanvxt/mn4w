{ lib, ... }: {
    options.truong-btw.enable = lib.mkEnableOption "";
    imports = [
        ./nix.nix
        ./boot.nix
        ./locale.nix
        ./networking.nix
        ./bluetooth.nix
        ./pipewire.nix
        ./graphics.nix
        ./greetd.nix
        ./programs.nix
        ./gaming.nix
        ./polkit.nix
    ];
}
