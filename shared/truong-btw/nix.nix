{ config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        nix = {
            settings = {
                auto-optimise-store = true;
                experimental-features = [ "nix-command" "flakes" ];

                allowed-users = [ "*" ];
                trusted-users = [ "root" "@wheel" ];
            };

            gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
            };

            optimise = {
                automatic = true;
                dates = "weekly";
            };
        };

        nixpkgs.config.allowUnfree = true;
    };
}
