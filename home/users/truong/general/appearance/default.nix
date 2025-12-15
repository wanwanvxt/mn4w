{pkgs, ...}: {
    imports = [
        ./cursor.nix
        ./fontconfig.nix
        ./qt
        ./gtk.nix
    ];

    home.packages = with pkgs; [
        papirus-icon-theme
        bibata-cursors
        sound-theme-freedesktop
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
    ];

    # Qt
    qt = {
        enable = true;
        platformTheme.name = "qtct";
        kde.settings.kdeglobals = {
            Icons.Theme = "Papirus-Dark";
            Sounds.Theme = "freedesktop";
        };
    };

    xdg.configFile."qt6ct/qt6ct.conf".text = builtins.replaceStrings ["%COLOR_SCHEME_PATH%"] ["${pkgs.kdePackages.qt6ct}/share/qt6ct/colors/darker.conf"] (builtins.readFile ./qt6ct.conf);
}
