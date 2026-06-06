{
    networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
    };

    location.provider = "geoclue2";
    services.geoclue2.enable = true;

    services.zapret = {
        enable = true;
        params = [
            "--dpi-desync=multisplit"
            "--dpi-desync-split-pos=2"
        ];
    };
}
