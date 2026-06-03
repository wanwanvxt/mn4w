{ pkgs, config, lib, ... }:
let
    gtkCfg = config.gtk;
    xdgCfg = config.xdg;
in
{
    home.packages = with pkgs; [
        matugen
        thaimeleon
    ];

    xdg.configFile = {
        "thaimeleon/thaimeleon.toml".text = ''
            [main]
            light_theme_threshold = ${if gtkCfg.colorScheme == "dark" then "1" else "0"}
            write_to_cache = false
            read_cache = false
            run_in_parallel = true

            [light]
            base_lightness_minimum = 0.9
            base_lightness_maximum = 0.95
            highlight_lightness_difference = 0.025
            surface_distance = 0.025

            set_2_dps_contrast = 6
            set_2_lightness_correction = 0.005
            set_3_dps_contrast = 25
            set_4_dps_contrast = 45
            set_5_dps_contrast = 65

            neutral_chroma_blend = 0.6

            bg_neutral_chroma_minimum = 0
            bg_neutral_chroma_maximum = 0.02
            fg_neutral_chroma_minimum = 0
            fg_neutral_chroma_maximum = 0.02

            prefered_hue_angle = 50
            minimum_hue_angle = 45

            maximum_accent_hue_center_translation = 0.02
            fg_accent_radius_baseline = 0.05
            rg_accent_radius_baseline = 0.04
            bg_accent_radius_baseline = 0.03

            red_chroma_minimum    = 0.05
            yellow_chroma_minimum = 0.06
            green_chroma_minimum  = 0.07

            [dark]
            base_lightness_minimum = 0.15
            base_lightness_maximum = 0.25
            highlight_lightness_difference = 0.025
            surface_distance = 0.025

            set_2_dps_contrast = 6
            set_2_lightness_correction = -0.025
            set_3_dps_contrast = 25
            set_4_dps_contrast = 45
            set_5_dps_contrast = 65

            neutral_chroma_blend = 0.6

            bg_neutral_chroma_minimum = 0
            bg_neutral_chroma_maximum = 0.02
            fg_neutral_chroma_minimum = 0
            fg_neutral_chroma_maximum = 0.02

            prefered_hue_angle = 50
            minimum_hue_angle  = 45

            maximum_accent_hue_center_translation = 0.02
            fg_accent_radius_baseline = 0.05
            rg_accent_radius_baseline = 0.04
            bg_accent_radius_baseline = 0.03

            red_chroma_minimum    = 0.05
            yellow_chroma_minimum = 0.06
            green_chroma_minimum  = 0.07
        '';

        "matugen/config.toml".text = ''
            [config]
            version_check = false
            import_json_files = [ "./chameleon.json" ]
        '';
    };

    home.activation.genChameleonDefaultPallete = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        TARGET_FILE="${xdgCfg.configHome}/matugen/chameleon.json"
        if ! [ -f "$TARGET_FILE" ]; then
            cat << EOF > "$TARGET_FILE"
${lib.readFile ./chameleon.json}
EOF
        fi
    '';
}
