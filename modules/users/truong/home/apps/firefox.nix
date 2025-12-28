{...}: {
    programs.firefox.enable = true;
    wayland.windowManager.hyprland.settings."$hypr_app_browser" = "firefox";
}
