{
    pkgs,
    inputs,
    ...
}: let
    std = inputs.nix-std.lib;
in {
    home.packages = with pkgs; [
        matugen
    ];

    xdg.configFile."matugen/config.toml".text = std.serde.toTOML {
        config = {
            version_check = false;
            fallback_color = "#9ece6a";
            caching = true;
        };
        templates = {};
    };
}
