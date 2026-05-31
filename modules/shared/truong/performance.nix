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
    ];
}
