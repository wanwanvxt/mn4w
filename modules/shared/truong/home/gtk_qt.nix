{ pkgs, config, lib, ... }:
let
    gtkCfg = config.gtk;
    qtCfg = config.qt;
in
{
# GTK
    gtk = {
        enable = true;
        colorScheme = "dark";
        theme = {
            name = if gtkCfg.colorScheme == "dark"
                then "Materia-dark" else "Materia-light";
            package = pkgs.materia-theme;
        };
        font = {
            name = "Sans";
            size = 12;
        };
        iconTheme = {
            name = if gtkCfg.colorScheme == "dark"
                then "Papirus-Dark" else "Papirus-Light";
            package = pkgs.papirus-icon-theme;
        };
    };

    home.sessionVariables.ADW_DISABLE_PORTAL = "1";
    systemd.user.sessionVariables.ADW_DISABLE_PORTAL = "1";

# Qt
    home.packages = with pkgs; [
        # papirus-icon-theme
        # libsForQt5.qt5t
        # qt6Packages.qt6ct
        libsForQt5.qtstyleplugin-kvantum
        qt6Packages.qtstyleplugin-kvantum
        kdePackages.qqc2-desktop-style
    ];

    qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = null;

        kvantum = {
            enable = true;
            themes = [ pkgs.materia-kde-theme ];
            settings = {
                General.theme = if gtkCfg.colorScheme == "dark"
                    then "MateriaDark" else "MateriaLight";
            };
        };
    };

    # some apps do not work properly with qt5ct. Eg: OBS
    home.sessionVariables.QT_QPA_PLATFORMTHEME =
        lib.mkIf (qtCfg.platformTheme.name == "qtct") (lib.mkForce "qt6ct");
    systemd.user.sessionVariables.QT_QPA_PLATFORMTHEME =
        lib.mkIf (qtCfg.platformTheme.name == "qtct") (lib.mkForce "qt6ct");
}
