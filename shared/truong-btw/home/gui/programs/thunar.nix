{ pkgs, config, lib, ... }:
let
    thunarCfg = config.programs.thunar or { enable = false; };
    helpers = import ../../helpers.nix lib;

    pkgThunar = pkgs.thunar.override {
        thunarPlugins = with pkgs; [
            thunar-volman
            (thunar-archive-plugin.overrideAttrs (oldAttrs: {
                postInstall = (oldAttrs.postInstall or "") + ''
                    cp ${pkgXarchiver}/libexec/thunar-archive-plugin/* $out/libexec/thunar-archive-plugin/
                '';
            }))
        ];
    };
    pkgXarchiver = pkgs.xarchiver.overrideAttrs (oldAttrs: {
        postFixup = (oldAttrs.postFixup or "") + ''
            wrapProgram $out/bin/xarchiver \
                --suffix PATH : ${lib.makeBinPath [ pkgs.rar ]}
        '';
    });
in
{
    options.programs.thunar.enable = lib.mkEnableOption "";

    config = lib.mkIf config.truong-btw.enable {
        programs.thunar.enable = true;

        home.packages = lib.optionals thunarCfg.enable [
            pkgThunar
            pkgXarchiver
        ];

        home.sessionVariables.FILE_MANAGER = lib.optionalString thunarCfg.enable "thunar";
        xdg.mimeApps.defaultApplications =
            lib.optionalAttrs thunarCfg.enable
            (helpers.assignMimes [
                "inode/directory"
                "x-scheme-handler/file"
                "x-scheme-handler/trash"
            ] [ "thunar.desktop" ]);
    };
}
