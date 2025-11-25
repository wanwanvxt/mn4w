{ config, osConfig, pkgs, inputs, ... }:
{
    home.stateVersion = osConfig.system.stateVersion;

    wayland.windowManager.hyprland.enable = true;
    programs = {
        # shells
        bash.enable = true;
        fish.enable = true;

        ssh.enable = true;
        git = {
            enable = true;
            package = pkgs.gitFull;
        };
        lazygit.enable = true;
        helix.enable = true;

        # gui apps
        kitty.enable = true;
        firefox.enable = true;
        vscode.enable = true;
        vesktop.enable = true;

        # utilities
        btop.enable = true;
        fastfetch.enable = true;
    };
    services = {
        playerctld.enable = true;
    };
    home.packages = with pkgs; [
        # gui apps
        kdePackages.qtsvg kdePackages.kio-fuse kdePackages.kio-extras
        kdePackages.dolphin kdePackages.ark
        vlc pqiv

        # utilities
        xdg-utils libnotify brightnessctl
        wl-clipboard slurp wayshot jq
        nvtopPackages.full tree

        # developments
        nixd
        gcc clang-tools cmakeWithGui xmake
    ];

    imports = [
        ./btop.nix
        ./fastfetch.nix
        ./git.nix
        ./helix.nix
        ./hyprland
        ./ime.nix
        ./kitty.nix
        ./shell.nix
        ./ssh.nix
        ./theme.nix
        ./xdg.nix
        ./vesktop.nix
    ];
}
