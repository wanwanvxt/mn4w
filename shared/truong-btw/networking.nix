{ pkgs, config, lib, ... }:
let
    localProxyAddr = "127.0.0.1:8080";
in
{
    config = lib.mkIf config.truong-btw.enable {
        networking = {
            proxy.default = "http://${localProxyAddr}";
            nftables.enable = true;
            firewall.enable = true;
            networkmanager = {
                enable = true;
                wifi.backend = "iwd";
            };
        };

        systemd.services = {
            spoofdpi = {
                description = "SpoofDPI - Simple and fast anti-censorship tool";
                after = [ "network.target" ];
                wantedBy = [ "multi-user.target" ];
                serviceConfig = {
                    ExecStart = "${pkgs.spoofdpi}/bin/spoofdpi --listen-addr ${localProxyAddr} --dns-mode https --dns-https-url https://1.1.1.1/dns-query";
                    Restart = "on-failure";
                };
            };

            nix-daemon.environment = {
                http_proxy  = lib.mkForce "";
                https_proxy = lib.mkForce "";
                all_proxy   = lib.mkForce "";
                HTTP_PROXY  = lib.mkForce "";
                HTTPS_PROXY = lib.mkForce "";
                ALL_PROXY   = lib.mkForce "";
            };
        };

        location.provider = "geoclue2";
        services.geoclue2.enable = true;
    };
}
