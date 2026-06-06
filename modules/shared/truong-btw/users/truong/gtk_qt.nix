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
            name = "Adwaita";
            package = pkgs.gnome-themes-extra;
        };
        font = {
            name = "Sans";
            size = 12;
        };
        iconTheme = {
            name =
                if gtkCfg.colorScheme == "dark"
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
        kdePackages.qqc2-desktop-style
        kdePackages.breeze
    ];

    qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = null;
    };

    # some apps do not work properly with qt5ct. Eg: OBS
    home.sessionVariables.QT_QPA_PLATFORMTHEME =
        lib.mkIf (qtCfg.enable && qtCfg.platformTheme.name == "qtct") (lib.mkForce "qt6ct");
    systemd.user.sessionVariables.QT_QPA_PLATFORMTHEME =
        lib.mkIf (qtCfg.enable && qtCfg.platformTheme.name == "qtct") (lib.mkForce "qt6ct");
}
