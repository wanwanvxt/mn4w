{ pkgs, config, osConfig, lib, ... }:
let
    nvidiaCfg = osConfig.hardware.nvidia;
    nvidiaOffloadCfg = osConfig.hardware.nvidia.prime.offload;
    powerprofilesCfg = osConfig.services.power-profiles-daemon;
    gamescopeCfg = osConfig.programs.gamescope;
    mangohudCfg = config.programs.mangohud;

    nvidiaOffloadEnable =
        nvidiaCfg.enabled &&
        nvidiaOffloadCfg.enable &&
        nvidiaOffloadCfg.enableOffloadCmd;
in
{
    programs.mangohud = {
        enable = true;
        settings = {
            legacy_layout = 0;
            position = "top-left";
            font_size = "18";
            text_outline = true;

            fps_limit= [ 0 60 75 120 144 165 240 ];
            fps_limit_method = "late";

            preset = [ 1 2 3 ];
        };
    };
    xdg.configFile."MangoHud/presets.conf".text = ''
        [preset 1]
        hud_no_margin
        background_alpha=0
        fps_only

        [preset 2]
        hud_no_margin
        horizontal

        fps
        frametime
        frame_timing

        gpu_stats
        gpu_temp
        vram

        cpu_stats
        cpu_temp
        ram

        [preset 3]
        round_corners=4

        fps
        frametime
        frame_timing
        fps_metrics=avg,0.1,0.01

        gpu_stats
        gpu_temp
        gpu_core_clock
        gpu_power
        vram

        cpu_stats
        cpu_temp
        cpu_mhz
        cpu_power
        ram

        io_read
        io_write

        resolution
        present_mode
        display_server
        gamemode
        vkbasalt
        show_fps_limit
        throttling_status

        fps_color_change
        gpu_load_change
        cpu_load_change
    '';

    home.packages = with pkgs; [
        protonplus

        (lib.mkIf powerprofilesCfg.enable (writeShellScriptBin "performance-run" ''
            if ! powerprofilesctl list | grep -q 'performance:'; then
                exec "$@"
            fi

            exec systemd-inhibit --who="$*" --why='Performance mode' \
                powerprofilesctl launch -p performance -i "$*" -r 'Performance mode' \
                -- "$@"
        ''))

        (writeShellScriptBin "game-run" ''
            exec \
                ${lib.optionalString powerprofilesCfg.enable "performance-run"} \
                ${lib.optionalString nvidiaOffloadEnable nvidiaOffloadCfg.offloadCmdMainProgram} \
                ${lib.optionalString mangohudCfg.enable "mangohud"} \
                "$@"
        '')

        (lib.mkIf gamescopeCfg.enable (writeShellScriptBin "gamescope-run" ''
            export GAMESCOPE_ARGS=''${GAMESCOPE_ARGS:-}

            exec \
                ${lib.optionalString powerprofilesCfg.enable "performance-run"} \
                gamescope \
                ${lib.optionalString mangohudCfg.enable "--mangoapp"} \
                $GAMESCOPE_ARGS \
                -- \
                ${lib.optionalString nvidiaOffloadEnable nvidiaOffloadCfg.offloadCmdMainProgram} \
                "$@"
        ''))
    ];
}
