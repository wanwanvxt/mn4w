{ pkgs, config, lib, ... }:
let
    nvidiaCfg = config.hardware.nvidia;
    nvidiaOffloadCfg = config.hardware.nvidia.prime.offload;
    powerprofilesCfg = config.services.power-profiles-daemon;
    gamescopeCfg = config.programs.gamescope;

    nvidiaOffloadEnable =
        nvidiaCfg.enabled &&
        nvidiaOffloadCfg.enable &&
        nvidiaOffloadCfg.enableOffloadCmd;
in
{
    programs = {
        steam = {
            enable = true;
            protontricks.enable = true;

            localNetworkGameTransfers.openFirewall = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };

        gamescope = {
            enable = true;
            capSysNice = true;
        };
    };

    environment.systemPackages = with pkgs; [
        (writeShellScriptBin "game-run" ''
            exec \
                ${lib.optionalString powerprofilesCfg.enable "performance-run"} \
                ${lib.optionalString nvidiaOffloadEnable nvidiaOffloadCfg.offloadCmdMainProgram} \
                "$@"
        '')

        (lib.mkIf gamescopeCfg.enable (writeShellScriptBin "gamescope-run" ''
            export GAMESCOPE_ARGS=''${GAMESCOPE_ARGS:-}

            exec \
                ${lib.optionalString powerprofilesCfg.enable "performance-run"} \
                gamescope \
                $GAMESCOPE_ARGS \
                -- \
                ${lib.optionalString nvidiaOffloadEnable nvidiaOffloadCfg.offloadCmdMainProgram} \
                "$@"
        ''))
    ];
}
