{ config, pkgs, inputs, ... }:
{
    programs.fastfetch.settings = {
        logo.padding.top = 2;
        modules = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "editor"
            "display"
            "monitor"
            "lm"
            "de"
            "wm"
            "wmtheme"
            "theme"
            "icons"
            "font"
            "cursor"
            "wallpaper"
            "terminal"
            "terminalfont"
            "terminalsize"
            "terminaltheme"
            {
                type = "cpu";
                showPeCoreCount = true;
            }
            {
                type = "gpu";
                driverSpecific = true;
            }
            "memory"
            "physicalmemory"
            {
                type = "swap";
                separate = true;
            }
            "disk"
            "btrfs"
            "zpool"
            "battery"
            "poweradapter"
            "localip"
            "datetime"
            "locale"
            "vulkan"
            "opengl"
            "opencl"
            "netio"
            "diskio"
            "physicaldisk"
            "tpm"
            "version"
            "break"
            "colors"
        ];
    };
}
