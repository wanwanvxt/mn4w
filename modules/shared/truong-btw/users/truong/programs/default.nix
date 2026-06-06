{ pkgs, ... }: {
    home.packages = with pkgs; [
        trash-cli

        qbittorrent
        protonplus
    ];

    imports = [
        ./bash.nix
        ./git.nix
        ./ssh.nix
        ./neovim

        ./kitty.nix
        ./nemo.nix
        ./firefox.nix
        ./imv.nix
        ./mpv.nix
        ./mangohud.nix
    ];
}
