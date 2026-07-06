{ pkgs, osConfig, config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    uwsmCfg = osConfig.programs.uwsm;
    homeCfg = config.home;
    rofiCfg = config.programs.rofi;
    wireplumberCfg = osConfig.services.pipewire.wireplumber;
    hyprshotCfg = config.programs.hyprshot;
in
{
    imports = [
        ./uwsm.nix
        ./hyprshot.nix
        ./rofi.nix
    ];

    config = lib.mkIf config.truong-btw.enable {
        home.pointerCursor = {
            enable = true;
            dotIcons.enable = true;
            x11.enable = true;
            gtk.enable = true;
            hyprcursor.enable = hyprlandCfg.enable;

            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 24;
        };

        xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                hyprlandCfg.finalPortalPackage
                xdg-desktop-portal-gtk
            ];
            config.hyprland.default = [ "hyprland" "gtk" ];
        };

        wayland.windowManager.hyprland = {
            enable = true;
            configType = "lua";
            systemd = {
                enable = !uwsmCfg.enable;
                variables = [ "--all" ];
                enableXdgAutostart = true;
            };
            xwayland.enable = true;
            extraConfig = ''
                _G.mainMod = "SUPER";

                _G.terminal    = "${homeCfg.sessionVariables.TERMINAL or ""}";
                _G.browser     = "${homeCfg.sessionVariables.BROWSER or ""}";
                _G.fileManager = "${homeCfg.sessionVariables.FILE_MANAGER or ""}";

                _G.rofi        = "${lib.getExe (if rofiCfg.enable then rofiCfg.finalPackage else pkgs.rofi)}"

                _G.brightnessctl = "${lib.getExe pkgs.brightnessctl}"
                _G.wpctl         = "${if wireplumberCfg.enable then wireplumberCfg.package else pkgs.wireplumber}/bin/wpctl"
                _G.playerctl     = "${lib.getExe pkgs.playerctl}"
                _G.hyprshot      = "${lib.getExe (if hyprshotCfg.enable then hyprshotCfg.package else pkgs.hyprshot)}"

                local modules = require("hyprland.init")
                for _, module in ipairs(modules) do
                    local status, err = pcall(require, "hyprland." .. module)
                    if not status then
                        local msg = string.format("Module '%s' cannot be loaded!\n", module)
                        print(msg, err)
                    end
                end

                pcall(require, "custom")
            '';
        };

        xdg.configFile = (lib.optionalAttrs hyprlandCfg.enable {
            "hypr/hyprland".source = ./config;
        });
    };
}
