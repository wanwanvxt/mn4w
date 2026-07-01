{ config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        networking = {
            firewall.enable = true;
            networkmanager = {
                enable = true;
                wifi.backend = "iwd";
            };
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
    };
}
