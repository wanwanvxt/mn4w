{ pkgs, ... }: {
    imports = [
        ./kitty.nix
        ./nemo.nix
        ./firefox.nix
        ./imv.nix
        ./mpv.nix
        ./gaming.nix
    ];

    home.packages = with pkgs; [
        qbittorrent
    ];
}
