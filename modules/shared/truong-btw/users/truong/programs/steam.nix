{ pkgs, osConfig, lib, ... }:
let
    steamCfg = osConfig.programs.steam;
in
{
    systemd.user.services.steam-shader-cfg = lib.mkIf steamCfg.enable {
        Unit = {
            Description = "Configure Steam shader preprocessing threads";
        };

        Install = {
            WantedBy = [ "default.target" ];
        };

        Service = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.writeShellScript "steam-shader-cfg-script" ''
                THREADS=$(${pkgs.coreutils}/bin/nproc)
                mkdir -p ~/.steam/steam
                echo "unShaderBackgroundProcessingThreads $THREADS" > ~/.steam/steam/steam_dev.cfg
            ''}";
        };
    };
}
