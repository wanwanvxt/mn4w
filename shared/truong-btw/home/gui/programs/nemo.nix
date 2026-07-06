{ pkgs, config, lib, ... }:
let
    nemoCfg = config.programs.nemo or { enable = false; };
    helpers = import ../../helpers.nix lib;
in
{
    options.programs.nemo.enable = lib.mkEnableOption "";

    config = lib.mkIf config.truong-btw.enable {
        programs.nemo.enable = true;

        home.packages = lib.optionals nemoCfg.enable (with pkgs; [
            nemo
            (xarchiver.overrideAttrs (oldAttrs: {
                postFixup = (oldAttrs.postFixup or "") + ''
                    wrapProgram $out/bin/xarchiver \
                        --suffix PATH : ${lib.makeBinPath [ pkgs.rar ]}
                '';
            }))
        ]);

        home.sessionVariables.FILE_MANAGER = lib.optionalString nemoCfg.enable "nemo";
        xdg.mimeApps.defaultApplications =
            lib.optionalAttrs nemoCfg.enable
            (helpers.assignMimes [
                "inode/directory"
                "x-scheme-handler/file"
                "x-scheme-handler/trash"
                "application/x-gnome-saved-search"
            ] [ "nemo.desktop" ]);

        dconf.settings = {
            "org/nemo/plugins".disabled-actions = lib.optionals nemoCfg.enable [
                "90_new-launcher.nemo_action"
                "add-desklets.nemo_action"
                "change-background.nemo_action"
                "mount-archive.nemo_action"
                "set-as-background.nemo_action"
                "set-resolution.nemo_action"
            ];
        };
    };
}
