{...}: {
    system.stateVersion = "25.05";

    imports = [
        ./boot.nix
        ./nix.nix
        ./networking.nix
        ./audio.nix
        ./bluetooth.nix
        ./graphics.nix
        ./misc.nix
    ];
}
