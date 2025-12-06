{ osConfig, pkgs, ... }:
{
    home.stateVersion = osConfig.system.stateVersion;

    programs = {
        quickshell.enable = true;
        firefox.enable = true;
    };
    services = {
        playerctld.enable = true;
    };
    home.packages = with pkgs; [
        # gui apps
        kdePackages.qtsvg kdePackages.kio-fuse kdePackages.kio-extras
        kdePackages.dolphin kdePackages.ark
        vlc pqiv aseprite qalculate-qt

        # utilities
        bash-language-server fish-lsp nixd alejandra
        xdg-utils libnotify brightnessctl
        wl-clipboard slurp wayshot jq
        nvtopPackages.full tree unrar
        libqalculate
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
        ./starship.nix
        ./theme.nix
        ./xdg.nix
        ./vesktop.nix
    ];
}
