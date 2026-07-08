{ pkgs, config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        environment = {
            systemPackages = with pkgs; [
                tree
                less
                fzf
                ripgrep
                neovim

                git
                curl
                wget

                htop
                gdu
            ];

            variables = {
                EDITOR = "nvim";
                VISUAL = "nvim";
                PAGER = "less";
                MANPAGER = "nvim +Man!";
            };

            pathsToLink = [
                "/share/applications"
                "/share/xdg-desktop-portal"
                "/share/color-schemes"
                "/share/fish"
                "/share/hypr"
            ];
        };

        programs = {
            less.enable = lib.mkForce false;
            nano.enable = false;
            dconf.enable = true;
            xfconf.enable = true;
        };

        services = {
            upower.enable = true;
            power-profiles-daemon.enable = true;
            gvfs.enable = true;
            udisks2.enable = true;
            gnome.gnome-keyring.enable = true;
        };
    };
}
