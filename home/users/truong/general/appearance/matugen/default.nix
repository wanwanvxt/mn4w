{
    config,
    pkgs,
    lib,
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
            fallback_color = "#9ece6a";
            caching = true;
        };
        templates =
            {}
            // (lib.optionalAttrs config.wayland.windowManager.hyprland.enable {
                hyprland = {
                    input_path = "${config.xdg.configHome}/matugen/templates/hyprland.conf";
                    output_path = "${config.xdg.configHome}/hypr/hyprland/colors.conf";
                };
            })
            // (lib.optionalAttrs (config.qt.enable && config.qt.platformTheme.name == "qtct") {
                qtct = {
                    input_path = "${config.xdg.configHome}/matugen/templates/qtct.conf";
                    output_path = "${config.xdg.configHome}/qt6ct/colors/qtct.conf";
                };
            });
    };
}
