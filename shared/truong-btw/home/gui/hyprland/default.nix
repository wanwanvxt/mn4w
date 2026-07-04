{ pkgs, osConfig, config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    uwsmCfg = osConfig.programs.uwsm;
    homeCfg = config.home;
    xdgCfg = config.xdg;
    wireplumberCfg = osConfig.services.pipewire.wireplumber;
    hyprshotCfg = config.programs.hyprshot;

    hyprScriptFiles = lib.mapAttrs' (name: value: {
        name = "hypr/scripts/${name}";
        value = {
            source = ./scripts/${name};
            executable = true;
        };
    }) (lib.filterAttrs (name: type: type == "regular") (builtins.readDir ./scripts));
in
{
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
                _G.hyprConfigDir = "${xdgCfg.configHome}/hypr"

                _G.mainMod = "SUPER";

                _G.terminal    = "${homeCfg.sessionVariables.TERMINAL or ""}";
                _G.browser     = "${homeCfg.sessionVariables.BROWSER or ""}";
                _G.fileManager = "${homeCfg.sessionVariables.FILE_MANAGER or ""}";

                _G.brightnessctl = "${lib.getExe pkgs.brightnessctl}" or "brightnessctl"
                _G.wpctl         = "${wireplumberCfg.package}/bin/wpctl" or "wpctl"
                _G.playerctl     = "${lib.getExe pkgs.playerctl}" or "playerctl"
                _G.hyprshot      = "${lib.getExe hyprshotCfg.package}" or "hyprshot"


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
        }) //
        (lib.optionalAttrs hyprlandCfg.enable hyprScriptFiles) //
        (lib.optionalAttrs uwsmCfg.enable {
            "uwsm/default-id".text = "hyprland-uwsm.desktop";

            "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
            "uwsm/env.d/10-wl.conf".text = ''
                export GDK_BACKEND=wayland,x11,*
                export CLUTTER_BACKEND=wayland
                export QT_QPA_PLATFORM=wayland;xcb
                export ELECTRON_OZONE_PLATFORM_HINT=auto
                export PROTON_ENABLE_WAYLAND=1
                export SDL_VIDEODRIVER=wayland
                export SDL_VIDEO_DRIVER=wayland

                export QT_AUTO_SCREEN_SCALE_FACTOR=1
            '';
            "uwsm/env-hyprland".text = ''
                export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            '';
        });

        programs.hyprshot = {
            enable = hyprlandCfg.enable;
            saveLocation = "${xdgCfg.userDirs.pictures or "~"}/screenshots";
        };
    };
}
