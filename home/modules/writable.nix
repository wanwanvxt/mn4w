{ config, lib, ... }:
let
    mkOpt = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule {
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
                override = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                };
            };
        });
        default = {};
    };

    cfgHome = config.writable.homeFile;
    cfgXdgCfg = config.writable.xdgConfigFile;

    mkFilteredCfg = cfg: (lib.filterAttrs (_: value: value.source != null || value.text != null) cfg);
    filteredCfgHome = mkFilteredCfg cfgHome;
    filteredCfgXdgCfg = mkFilteredCfg cfgXdgCfg;

    mkActivationEntries = cfg: baseDir:
        lib.mapAttrs (name: value:
            let
                targetPath = "${baseDir}/${name}";

                writeSourceCmd = if value.source != null then
                        if lib.pathIsDirectory value.source then
                            "run cp -r '${value.source}' '${targetPath}'"
                        else "run install -Dm0644 '${value.source}' '${targetPath}'"
                    else "";
                writeTextCmd = if value.text != null then
                        let
                            textList = lib.lists.toList value.text;
                            fullText = lib.escapeShellArg (lib.concatStringsSep "\n" textList);
                        in "run echo -e ${fullText} > '${targetPath}'"
                    else "";
                writeCmd = if writeSourceCmd != "" then writeSourceCmd else writeTextCmd;

                rmCmd = if value.override then "run rm -rf '${targetPath}'" else "";
                chmodCmd = if value.executable then "run chmod +x '${targetPath}'" else "";
            in
                lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                    ${rmCmd}
                    if [ ! -e '${targetPath}' ]; then
                        run mkdir -p '$(dirname '${targetPath}')'
                        ${writeCmd}
                        ${chmodCmd}
                    fi
                ''
        ) cfg;
in
{
    options.writable = {
        homeFile = mkOpt;
        xdgConfigFile = mkOpt;
    };

    config = {
        home.activation = lib.mkMerge [
            (mkActivationEntries filteredCfgHome config.home.homeDirectory)
            (mkActivationEntries filteredCfgXdgCfg config.xdg.configHome)
        ];
    };
}
