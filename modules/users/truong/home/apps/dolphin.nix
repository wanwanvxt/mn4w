{pkgs, ...}: {
    home.packages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.kio-fuse
        kdePackages.kio-extras

        kdePackages.dolphin
        kdePackages.ark

        # plugins
        kdePackages.dolphin-plugins
        p7zip
        unrar
    ];

    wayland.windowManager.hyprland.settings."$hypr_app_file" = "dolphin";
}
