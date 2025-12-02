{ config, pkgs, lib, inputs, ... }:
let
    mkWritableType = baseDir: {
        options = {
            text = lib.mkOption {
                type = lib.types.nullOr lib.types.lines;
                default = null;
            };
            source = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
            };
            executable = lib.mkOption {
                type = lib.types.bool;
                default = false;
            };
            overwrite = lib.mkOption {
                type = lib.types.bool;
                default = true;
            };
        };
    };

    config = let
            path = baseDir + "/${config._module.args.name}";
            cfg = config._module.args.value;

            textCmd = if cfg.text != null && cfg.source == null then
                    let lines = lib.concatStringsSep "\n" (lib.mapAttrs (_: line: lib.escapeShell line) cfg.text);
                    in "printf '%s\\n' ${lines} > \"$target\""
                else "";
            sourceCmd = if cfg.source != null then
                    if lib.pathIsDirectory cfg.source then
                        "cp -r '${cfg.source}' \"$target\""
                    else
                        "install -Dm0644 '${cfg.source}' \"$target\""
                else "";
            rmCmd = if cfg.overwrite then "rm -rf \"$target\"" else "";
            chmodCmd = if cfg.executable then "chmod +x \"$target\"" else "";

        in lib.mkIf (cfg.source != null || cfg.text != null) {
            home.activation."writable-${config._module.args.name}" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                target="${path}"
                ${rmCmd}
                mkdir -p "$(dirname "$target")"
                ${textCmd}
                ${sourceCmd}
                ${chmodCmd}
            '';
        };
in
{
    options.writable = {
        homeFile = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule (mkWritableType config.home.homeDirectory));
            default = {};
        };

        xdgConfigFile = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule (mkWritableType config.xdg.configHome));
            default = {};
        };
    };
}
