{ pkgs, config, lib, ... }:
let
    helpers = import ../../helpers.nix lib;
in
{
    config = lib.mkIf config.truong-btw.enable {
        home.packages = with pkgs; [
            (thunar.override {
                thunarPlugins = with pkgs; [
                    thunar-volman
                    thunar-archive-plugin
                ];
            })
            xarchiver
        ];

        home.sessionVariables.FILE_MANAGER = "thunar";
        xdg.mimeApps.defaultApplications = helpers.assignMimes [
            "inode/directory"
            "x-scheme-handler/file"
        ] [ "thunar.desktop" ];
    };
}
