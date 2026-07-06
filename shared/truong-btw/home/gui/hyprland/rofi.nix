{ pkgs, config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    gtkCfg = config.gtk;
    xdgTermExecCfg = config.xdg.terminal-exec;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.rofi = {
            enable = hyprlandCfg.enable;
            plugins = with pkgs; [
                rofi-calc
            ];

            font =
                if gtkCfg.enable
                then "${gtkCfg.font.name} ${toString gtkCfg.font.size}"
                else "sans 12";
            terminal = lib.optionalString xdgTermExecCfg.enable "xdg-terminal-exec";
            cycle = false;
            location = "center";
            modes = [ "drun" "calc" ];
            extraConfig = {
                run-command =
                    let
                        cmd = "uwsm check is-active && exec uwsm app -- {cmd} || exec {cmd}";
                    in
                        if hyprlandCfg.enable then "hyprctl dispatch 'hl.dsp.exec_cmd(\"${cmd}\")'"
                        else "sh -c '${cmd}'";
            };
        };
    };
}
