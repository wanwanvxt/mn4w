{
    config,
    pkgs,
    inputs,
    ...
}: let
    std = inputs.nix-std.lib;
in {
    home.packages = with pkgs; [
        matugen
    ];

    xdg.configFile."matugen/templates".source = ./templates;

    xdg.configFile."matugen/config.toml".text = std.serde.toTOML {
        config = {
            version_check = false;
            fallback_color = "#00ff99";
            caching = true;
        };
        templates = {
            hyprland = {
                input_path = "${config.xdg.configHome}/matugen/templates/hyprland.conf";
                output_path = "${config.xdg.configHome}/hypr/hyprland/colors.conf";
            };
            colorScheme = {
                input_path = "${config.xdg.configHome}/matugen/templates/Matugen.colors";
                output_path = "${config.xdg.dataHome}/color-schemes/Matugen.colors";
            };
        };
    };
}
