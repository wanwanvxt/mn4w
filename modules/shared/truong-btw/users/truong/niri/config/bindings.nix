{ pkgs, osConfig, config, lib, ... }:
let
    niriCfg = config.programs.niri;
    xdgCfg = config.xdg;
    pipewireCfg = osConfig.services.pipewire;
    wireplumberCfg = osConfig.services.pipewire.wireplumber;
in
{
    config = lib.mkIf niriCfg.enable {
        xdg.configFile."niri/config/bindings.kdl".text = ''
            recent-windows {
                binds {
                    Alt+Tab         { next-window     scope="workspace"; }
                    Alt+Shift+Tab   { previous-window scope="workspace"; }
                    Alt+Grave       { next-window     scope="workspace" filter="app-id"; }
                    Alt+Shift+Grave { previous-window scope="workspace" filter="app-id"; }
                }
            }

            binds {
                Ctrl+Alt+Delete repeat=false { quit; }

                // workspaces
                Mod+1     repeat=false { focus-workspace 1; }
                Mod+2     repeat=false { focus-workspace 2; }
                Mod+3     repeat=false { focus-workspace 3; }
                Mod+4     repeat=false { focus-workspace 4; }
                Mod+5     repeat=false { focus-workspace 5; }
                Mod+6     repeat=false { focus-workspace 6; }
                Mod+7     repeat=false { focus-workspace 7; }
                Mod+8     repeat=false { focus-workspace 8; }
                Mod+9     repeat=false { focus-workspace 9; }
                Mod+0     repeat=false { focus-workspace 10; }
                Mod+Prior repeat=false { focus-workspace-up; }
                Mod+Next  repeat=false { focus-workspace-down; }

                // windows
                Mod+Tab repeat=false { toggle-overview; }
                //# common
                Mod+Escape repeat=false { close-window; }
                Alt+F4     repeat=false { close-window; }
                Mod+F      repeat=false { fullscreen-window; }
                Mod+Alt+F  repeat=false { toggle-windowed-fullscreen; }
                Mod+D      repeat=false { maximize-window-to-edges; }
                Mod+V      repeat=false { toggle-window-floating; }
                //# focus
                Mod+H    { focus-column-left; }
                Mod+J    { focus-window-down; }
                Mod+K    { focus-window-up; }
                Mod+L    { focus-column-right; }
                Mod+Home { focus-column-first; }
                Mod+End  { focus-column-last; }
                //# moving
                Mod+Shift+1     { move-window-to-workspace 1; }
                Mod+Shift+2     { move-window-to-workspace 2; }
                Mod+Shift+3     { move-window-to-workspace 3; }
                Mod+Shift+4     { move-window-to-workspace 4; }
                Mod+Shift+5     { move-window-to-workspace 5; }
                Mod+Shift+6     { move-window-to-workspace 6; }
                Mod+Shift+7     { move-window-to-workspace 7; }
                Mod+Shift+8     { move-window-to-workspace 8; }
                Mod+Shift+9     { move-window-to-workspace 9; }
                Mod+Shift+0     { move-window-to-workspace 10; }
                Mod+Shift+Prior { move-window-to-workspace-up; }
                Mod+Shift+Next  { move-window-to-workspace-down; }
                Mod+Shift+H { consume-or-expel-window-left; }
                Mod+Shift+J { move-window-down; }
                Mod+Shift+K { move-window-up; }
                Mod+Shift+L { consume-or-expel-window-right; }
                //# resizing
                Mod+Up    { switch-preset-window-height-back; }
                Mod+Down  { switch-preset-window-height; }
                Mod+Left  { switch-preset-column-width-back; }
                Mod+Right { switch-preset-column-width; }
                Mod+Alt+Up    { reset-window-height; }
                Mod+Alt+Down  { reset-window-height; }
                Mod+Alt+left  { maximize-column; }
                Mod+Alt+Right { maximize-column; }

                // apps
                Mod+T repeat=false { spawn-sh "${xdgCfg.configHome}/niri/scripts/spawn $TERMINAL"; }
                Mod+B repeat=false { spawn-sh "${xdgCfg.configHome}/niri/scripts/spawn $BROWSER"; }
                Mod+E repeat=false { spawn-sh "${xdgCfg.configHome}/niri/scripts/spawn $FILE_MANAGER"; }

                // media
                XF86MonBrightnessUp   allow-when-locked=true { spawn-sh "${lib.getExe pkgs.brightnessctl} --class=backlight set 2%+"; }
                XF86MonBrightnessDown allow-when-locked=true { spawn-sh "${lib.getExe pkgs.brightnessctl} --class=backlight set 2%-"; }
                XF86AudioPlay         allow-when-locked=true { spawn-sh "${lib.getExe pkgs.playerctl} play-pause"; }
                XF86AudioStop         allow-when-locked=true { spawn-sh "${lib.getExe pkgs.playerctl} stop"; }
                XF86AudioPrev         allow-when-locked=true { spawn-sh "${lib.getExe pkgs.playerctl} previous"; }
                XF86AudioNext         allow-when-locked=true { spawn-sh "${lib.getExe pkgs.playerctl} next"; }
                ${lib.optionalString (pipewireCfg.enable && wireplumberCfg.enable) ''
                    XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "${wireplumberCfg.package}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1"; }
                    XF86AudioLowerVolume allow-when-locked=true { spawn-sh "${wireplumberCfg.package}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"; }
                    XF86AudioMute        allow-when-locked=true { spawn-sh "${wireplumberCfg.package}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
                    XF86AudioMicMute     allow-when-locked=true { spawn-sh "${wireplumberCfg.package}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
                ''}

                // misc
                Print      repeat=false { screenshot-screen; }
                Alt+Print  repeat=false { screenshot-window; }
                Ctrl+Print repeat=false { screenshot; }
            }
        '';
    };
}
