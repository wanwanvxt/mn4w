{pkgs, ...}: {
    home.packages = with pkgs; [
        dconf
    ];

    gtk = {
        enable = true;
        theme.name = "Adwaita";
        iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
        };
        font = {
            package = pkgs.noto-fonts;
            name = "sans serif";
            size = 10;
        };
    };

    dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
    };
}
