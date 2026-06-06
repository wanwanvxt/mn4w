{ pkgs, osConfig, config, lib, ... }:
let
    niriCfg = config.programs.niri;
    uwsmCfg = osConfig.programs.uwsm;
in
{
    config = lib.mkIf niriCfg.enable {
        xdg.configFile."niri/scripts/spawn".source = pkgs.writeShellScript "niri-spawn-script" ''
            if ${if uwsmCfg.enable then "uwsm check is-active" else "false"}; then
                exec uwsm app -- "$@"
            else
                exec "$@"
            fi
        '';
    };
}
