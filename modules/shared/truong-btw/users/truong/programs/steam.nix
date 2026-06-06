{ pkgs, osConfig, lib, ... }:
let
    steamCfg = osConfig.programs.steam;
in
{
    systemd.user.services.steam-shader-cfg = lib.mkIf steamCfg.enable {
        description = "Configure Steam shader preprocessing threads";
        wantedBy = [ "default.target" ];

        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
        };

        script = ''
            THREADS=$(${pkgs.coreutils}/bin/nproc)
            mkdir -p ~/.local/share/Steam
            echo "unShaderBackgroundProcessingThreads $THREADS" > ~/.local/share/Steam/steam_dev.cfg
      '';
    };
}
