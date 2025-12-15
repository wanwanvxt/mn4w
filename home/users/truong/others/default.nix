{pkgs, ...}: {
    imports = [
        ./vesktop.nix
    ];

    programs = {
        firefox.enable = true;
        pqiv.enable = true;
    };

    home.packages = with pkgs; [
        vlc
        aseprite
        qalculate-qt
        nixd
        tree
    ];
}
