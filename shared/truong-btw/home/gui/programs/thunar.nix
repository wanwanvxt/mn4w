{ pkgs, config, lib, ... }:
let
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
                --prefix PATH : ${lib.makeBinPath [ pkgs.rar ]}
        '';
    });
in
{
    config = lib.mkIf config.truong-btw.enable {
        home.packages = [
            pkgThunar
            pkgXarchiver
        ];

        home.sessionVariables.FILE_MANAGER = "thunar";
        xdg.mimeApps.defaultApplications = helpers.assignMimes [
            "inode/directory"
            "x-scheme-handler/file"
            "x-scheme-handler/trash"
        ] [ "thunar.desktop" ];
    };
}
