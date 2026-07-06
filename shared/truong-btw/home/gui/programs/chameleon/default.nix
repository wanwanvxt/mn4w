{ pkgs, config, lib, ... }:
let
    chameleonCfg = config.programs.chameleon or { enable = false; };
in
{
    imports = [
        ./gtk_qt.nix
    ];

    options.programs.chameleon.enable = lib.mkEnableOption "";

    config = lib.mkIf config.truong-btw.enable {
        programs.chameleon.enable = true;

        home.packages = lib.optionals chameleonCfg.enable (with pkgs; [
            thaimeleon
            matugen
        ]);
    };
}
