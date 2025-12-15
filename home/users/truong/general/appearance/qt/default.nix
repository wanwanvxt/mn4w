{
    config,
    pkgs,
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

    xdg.configFile."qt6ct/qt6ct.conf".text = builtins.replaceStrings ["%COLOR_SCHEME_PATH%"] ["${config.xdg.configHome}/qt6ct/colors/qtct.conf"] (builtins.readFile ./qt6ct.conf);
    writable.xdgConfigFile."qt6ct/colors/qtct.conf".source = "${pkgs.kdePackages.qt6ct}/share/qt6ct/colors/darker.conf";
}
