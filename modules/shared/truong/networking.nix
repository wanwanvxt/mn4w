{
    networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
    };

    location.provider = "geoclue2";
    services.geoclue2.enable = true;
}
