{osConfig, ...}: {
    home.stateVersion = osConfig.system.stateVersion;

    imports = [
        ./shells
        ./vcs
        ./xdg.nix
        ./hyprland
        ./appearance
        ./ime.nix
        ./apps
    ];
}
