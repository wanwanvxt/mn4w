{
    users.users.truong = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.truong = { osConfig, ... }: {
            home.stateVersion = osConfig.system.stateVersion;
        };
    };

    security.polkit = {
        enable = true;
        extraConfig = ''
            polkit.addRule(function(action, subject) {
                if (subject.isInGroup("user") && (
                    action.id == "org.freedesktop.login1.reboot" ||
                    action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                    action.id == "org.freedesktop.login1.power-off" ||
                    action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
                    action.id == "org.freedesktop.login1.suspend" ||
                    action.id == "org.freedesktop.login1.suspend-multiple-sessions"
                )) {
                    return polkit.Result.YES;
                }
            });

            polkit.addRule(function(action, subject) {
                if (subject.isInGroup("networkmanager") && (
                    action.id == "org.freedesktop.NetworkManager.settings.modify.system" ||
                    action.id == "org.freedesktop.NetworkManager.network-control"
                )) {
                    return polkit.Result.YES;
                }
            })
        '';
    };
}
