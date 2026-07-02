{ pkgs, config, lib, ... }:
let
    gamemodeCfg = config.programs.gamemode;
    nvidiaCfg = config.hardware.nvidia;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs = {
            steam = {
                enable = true;
                localNetworkGameTransfers.openFirewall = true;
                remotePlay.openFirewall = true;
                dedicatedServer.openFirewall = true;
                extraCompatPackages = [ pkgs.proton-ge-bin ];
            };

            gamescope = {
                enable = true;
                capSysNice = true;
            };

            gamemode = {
                enable = true;
                enableRenice = true;
                settings = {
                    general = {
                        reaper_freq = 5;
                        desiredgov = "performance";
                        desiredprof = "performance";

                        igpu_desiredgov = "powersave";
                        igpu_power_threshold = 0.3;

                        renice = 10;
                        ioprio = 0;
                    };
                };
            };
        };

        environment.systemPackages = [
            (pkgs.writeShellScriptBin "game-run" ''
                [[ $# -eq 0 ]] && exit 1

                if [[ -n "$GAMESCOPE_WAYLAND_DISPLAY" ]] \
                    || [[ "$XDG_CURRENT_DESKTOP" == "gamescope" ]]; then
                    unset MANGOHUD
                    unset MANGOHUD_DLSYM
                fi

                cmd=()
                ${lib.optionalString gamemodeCfg.enable "cmd+=(gamemoderun)"}
                ${
                    lib.optionalString
                        (nvidiaCfg.enabled
                        && nvidiaCfg.prime.offload.enable
                        && nvidiaCfg.prime.offload.enableOffloadCmd)
                        "cmd+=(${nvidiaCfg.prime.offload.offloadCmdMainProgram})"
                }
                cmd+=("$@")

                exec "''${cmd[@]}"
            '')
        ];

        zramSwap = {
            enable = true;
            priority = 100;
            algorithm = "zstd";
            memoryPercent = 50;
            memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
        };
    };
}
