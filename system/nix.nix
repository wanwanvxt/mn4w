{ ... }:
{
    nix = {
        enable = true;
        settings = {
            allowed-users = [ "*" ];
            auto-optimise-store = true;
            experimental-features = [ "nix-command" "flakes" ];
            keep-outputs = true;
            keep-derivations = true;
        };
        gc = {
            automatic = true;
            dates = "daily";
            options = "--delete-older-than 7d";
        };
    };

    system.autoUpgrade = {
        enable = true;
        dates = "weekly";
    };

    nixpkgs.config.allowUnfree = true;
}
