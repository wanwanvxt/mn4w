{
    osConfig,
    pkgs,
    ...
}: {
    home.stateVersion = osConfig.system.stateVersion;

    imports = [
        ./xdg.nix
        ./ime.nix
        ./shell.nix
        ./starship.nix
        ./ssh.nix
        ./git.nix
        ./hyprland
        ./theme
        ./kitty.nix
        ./helix.nix
        ./btop.nix
        ./dolphin.nix
        ./vesktop.nix
    ];

    home.packages = with pkgs; [
        vlc
        qimgv
        aseprite
        qalculate-qt
        nixd
        tree
    ];
}
