{ config, pkgs, inputs, ... }:
{
    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        nerd-fonts._0xproto
        dconf
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
        hyprqt6engine
    ];

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            serif = [ "Noto Serif" ];
            sansSerif = [ "Noto Sans" ];
            monospace = [ "0xProto Nerd Font" "Noto Sans Mono" ];
            emoji = [ "Noto Color Emoji" ];
        };
    };

    home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        x11.enable = true;
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
    };

    # GTK
    gtk = {
        enable = true;
        theme.name = "Adwaita";
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
        };
        font = {
            name = "Noto Sans";
            package = pkgs.noto-fonts;
            size = 10;
        };
    };
    dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
    };

    # Qt
    qt = {
        enable = true;
        platformTheme.name = null;
    };

    home = {
        sessionVariables.QT_QPA_PLATFORMTHEME = "hyprqt6engine";
        sessionSearchVariables.QT_PLUGIN_PATH = [ "${pkgs.hyprqt6engine}/lib/qt-6" ];
    };

    xdg.configFile = {
        "hypr/hyprqt6engine.conf".text = ''
            theme {
                style = Breeze
                color_scheme = ${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors
                icon_theme = Papirus-Dark
                font = Noto Sans
                font_size = 10
                font_fixed = Noto Sans
                font_fixed_size = 10
            }

            misc {
                single_click_activate = true
                menus_have_icons = true
                shortcuts_for_context_menus = true
            }
        '';
        "kdeglobals".text = ''
            [Icons]
            Theme=Papirus-Dark
        '';
    };
}
