{ pkgs, ... }: {
    imports = [
        ./kitty.nix
        ./nemo.nix
        ./firefox.nix
        ./imv.nix
        ./mpv.nix
        ./mangohud.nix
    ];

    home.packages = with pkgs; [
        qbittorrent
        protonplus
    ];
}
