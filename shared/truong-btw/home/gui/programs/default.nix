{ pkgs, config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        home.packages = with pkgs; [
            qbittorrent
            protonplus
        ];

        services.polkit-gnome.enable = true;
    };

    imports = [
        ./chameleon
        ./ime.nix
        ./kitty.nix
        ./firefox.nix
        ./nemo.nix
        ./imv.nix
        ./mpv.nix
        ./mangohud.nix
    ];
}
