{ config, lib, ... }:
let
    firewallCfg = config.networking.firewall;
    zapretCfg = config.services.zapret;
in
{
    config = lib.mkIf config.truong-btw.enable {
        networking = {
            firewall.enable = true;
            nftables = {
                enable = true;
                ruleset = "" +
                    (lib.optionalString zapretCfg.enable (
                        let
                            httpParams = lib.optionalString (zapretCfg.httpMode == "first") "ct original packets 1-6 ";
                            udpPorts = lib.concatStringsSep ", " zapretCfg.udpPorts;
                            qnum = toString zapretCfg.qnum;
                        in
                        ''
                            table inet zapret {
                                chain mangle_postrouting {
                                    type filter hook postrouting priority mangle; policy accept;

                                    mark & 0x40000000 == 0x40000000 accept

                                    meta l4proto tcp tcp dport 443 ct original packets 1-6 queue num ${qnum} bypass

                                    ${lib.optionalString zapretCfg.httpSupport
                                        ''meta l4proto tcp tcp dport 80 ${httpParams}queue num ${qnum} bypass''}
                                    ${lib.optionalString (zapretCfg.udpSupport && zapretCfg.udpPorts != [])
                                        ''meta l4proto udp udp dport { ${udpPorts} } queue num ${qnum} bypass''}
                                }
                            }
                        ''
                    ));
            };

            networkmanager = {
                enable = true;
                wifi.backend = "iwd";
            };
        };

        services = {
            zapret = {
                enable = true;
                configureFirewall = firewallCfg.backend == "iptables";
                params = [
                    "--dpi-desync=multisplit"
                    "--dpi-desync-split-pos=2"
                ];
            };

            zerotierone.enable = true;
        };

        location.provider = "geoclue2";
        services.geoclue2.enable = true;
    };
}
