{ config, osConfig, pkgs, inputs, ... }:
{
    home.stateVersion = osConfig.system.stateVersion;

    programs = {
        quickshell = {
            enable = true;
            package = inputs.quickshell.packages.${pkgs.system}.default;
        };

        firefox.enable = true;
    };
    services = {
        playerctld.enable = true;
    };
    home.packages = with pkgs; [
        # gui apps
        kdePackages.qtsvg kdePackages.kio-fuse kdePackages.kio-extras
        kdePackages.dolphin kdePackages.ark
        vlc pqiv aseprite

        # utilities
        xdg-utils libnotify brightnessctl
        wl-clipboard slurp wayshot jq
        nvtopPackages.full tree unrar

        # developments
        bash-language-server fish-lsp nixd
        kdePackages.qtdeclarative
        gcc clang-tools cmakeWithGui xmake
    ];

    imports = [
        ./btop.nix
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
