{ pkgs, config, lib, ... }:
let
    gtkCfg = config.gtk;
    qtCfg = config.qt;
    dconfCfg = config.dconf;

    eventSoundsEnabled = dconfCfg.settings."org/gnome/desktop/sound".event-sounds or false;
    eventSoundsTheme   = dconfCfg.settings."org/gnome/desktop/sound".theme-name or "freedesktop";
    pkgSoundsTheme = lib.mkIf (dconfCfg.enable && eventSoundsEnabled) (
        if (eventSoundsTheme == "freedesktop") then pkgs.sound-theme-freedesktop
        else if (eventSoundsTheme == "oxygen") then pkgs.kdePackages.oxygen-sounds
        else null
    );
in
{
    config = lib.mkIf config.truong-btw.enable {
        # GTK
            gtk = {
                enable = true;
                colorScheme = "dark";
                theme = {
                    name =
                        if gtkCfg.colorScheme == "dark"
                        then "adw-gtk3-dark" else "adw-gtk3";
                    package = pkgs.adw-gtk3;
                };
                font = {
                    name = "sans";
                    size = 12;
                };
                iconTheme = {
                    name =
                        if gtkCfg.colorScheme == "dark"
                        then "Papirus-Dark" else "Papirus-Light";
                    package = pkgs.papirus-icon-theme;
                };

                gtk4.extraConfig = {
                    gtk-enable-event-sounds = eventSoundsEnabled;
                    gtk-sound-theme-name = eventSoundsTheme;
                };

                gtk3.extraConfig = {
                    gtk-button-images = true;
                    gtk-menu-images = true;
                    gtk-enable-event-sounds = eventSoundsEnabled;
                    gtk-sound-theme-name = eventSoundsTheme;
                };

                gtk2.extraConfig = ''
                    gtk-enable-event-sounds = ${toString eventSoundsEnabled}
                    gtk-sound-theme-name = "${eventSoundsTheme}"
                '';
            };

            dconf.settings = {
                "org/gnome/desktop/sound" = {
                    event-sounds = true;
                    theme-name = "oxygen";
                };
            };

        # Qt
            home.packages = with pkgs; [
                # papirus-icon-theme
                # libsForQt5.qt5t
                # qt6Packages.qt6ct
                pkgSoundsTheme
                kdePackages.qqc2-desktop-style
                darkly
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
    };
}
