{pkgs, ...}: {
    home.packages = with pkgs; [
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
        papirus-icon-theme
        sound-theme-freedesktop
    ];

    qt = {
        enable = true;
        platformTheme.name = "kde";
        kde.settings.kdeglobals = {
            General = {
                font = "sans serif,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
                fixed = "sans serif,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
                ColorScheme = "Matugen";
            };
            Icons.Theme = "Papirus";
            KDE.widgetStyle = "Breeze";
            Sounds.Theme = "freedesktop";
        };
    };

    writable.homeFile.".local/share/color-schemes/Matugen.colors".source = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
}
