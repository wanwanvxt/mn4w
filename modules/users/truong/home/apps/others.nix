{pkgs, ...}: {
    programs = {
        pqiv.enable = true;
    };

    home.packages = with pkgs; [
        vlc
        aseprite
        qalculate-qt
        wev
        nixd
        tree
    ];
}
