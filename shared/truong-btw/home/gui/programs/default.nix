{ pkgs, config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        home.packages = with pkgs; [
            qbittorrent
            protonplus
        ];
    };

    imports = [
        ./chameleon
        ./ime.nix
        ./kitty.nix
        ./firefox.nix
        ./thunar.nix
        ./imv.nix
        ./mpv.nix
        ./mangohud.nix
    ];
}
