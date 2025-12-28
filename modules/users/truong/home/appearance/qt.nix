{
    config,
    pkgs,
    lib,
    ...
}: {
    home.packages = with pkgs; [
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
        papirus-icon-theme
        noto-fonts
    ];

    qt = {
        enable = true;
        platformTheme.name = "qtct";
        kde.settings.kdeglobals = {
            Icons.Theme = "Papirus-Dark";
        };
    };

    xdg.configFile."qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
        Appearance = {
            style = "Breeze";
            color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/qtct.conf";
            custom_palette = true;
            icon_theme = "Papirus-Dark";
        };
        Fonts = {
            general = "\"sans serif,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular\"";
            fixed = "\"sans serif,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular\"";
        };
    };
    writable.xdgConfigFile."qt6ct/colors/qtct.conf".source = "${pkgs.kdePackages.qt6ct}/share/qt6ct/colors/darker.conf";
}
