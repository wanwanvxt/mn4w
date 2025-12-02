{ config, pkgs, inputs, ... }:
let
    qt6ctCfg = builtins.replaceStrings [ "{BREEZE_PATH}" ] [ "${pkgs.kdePackages.breeze}" ] (builtins.readFile ./qt6ct.conf);
in
{
    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        nerd-fonts._0xproto
        dconf
        papirus-icon-theme
        bibata-cursors
        kdePackages.breeze
        kdePackages.qqc2-desktop-style
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
        platformTheme.name = "qtct";
    };

    xdg.configFile = {
        "qt6ct/qt6ct.conf".text = qt6ctCfg;
    };
}
