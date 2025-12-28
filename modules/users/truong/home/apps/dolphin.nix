{pkgs, ...}: {
    home.packages = with pkgs; [
        # need these!?
        kdePackages.qtsvg
        kdePackages.kio-fuse
        kdePackages.kio-extras

        kdePackages.dolphin
        kdePackages.dolphin-plugins
        kdePackages.ark
        unrar
    ];

    wayland.windowManager.hyprland.settings."$hypr_app_file" = "dolphin";
}
