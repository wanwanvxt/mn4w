{ pkgs, config, lib, ... }:
let
    hyprlandCfg = config.wayland.windowManager.hyprland;
    gtkCfg = config.gtk;
    cliphistCfg = config.services.cliphist;
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
            terminal =
                if xdgTermExecCfg.enable then (lib.getExe xdgTermExecCfg.package)
                else (config.home.sessionVariables.TERMINAL or "");
            cycle = true;
            location = "center";
            modes = [
                "drun" "calc" "window"
                "clipboard:${
                    lib.getExe'
                    (if cliphistCfg.enable then cliphistCfg.package else pkgs.cliphist)
                    "cliphist-rofi"
                }"
            ];
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
