{...}: {
    services = {
        udisks2.enable = true;
        gvfs.enable = true;
        gnome.gnome-keyring.enable = true;
    };

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
}
