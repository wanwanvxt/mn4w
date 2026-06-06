{ pkgs, config, lib, ... }:
let
    powerprofilesCfg = config.services.power-profiles-daemon;
in
{
    zramSwap = {
        enable = true;
        priority = 100;
        algorithm = "zstd";
        memoryPercent = 50;
        memoryMax = 8 * 1024 * 1024 * 1024; # 8GiB
    };

    services.power-profiles-daemon.enable = true;
    environment.systemPackages = [
        (lib.mkIf powerprofilesCfg.enable (pkgs.writeShellScriptBin "performance-run" ''
            if ! powerprofilesctl list | grep -q 'performance:'; then
                exec "$@"
            fi

            exec systemd-inhibit --who="$*" --why='Performance mode' \
                powerprofilesctl launch -p performance -i "$*" -r 'Performance mode' \
                -- "$@"
        ''))
    ];
}
