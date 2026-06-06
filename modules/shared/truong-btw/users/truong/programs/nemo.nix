{ pkgs, lib, ... }:
let
    fileRollerDesktopPath = "${pkgs.file-roller}/share/applications/org.gnome.FileRoller.desktop";
    helpers = import ./helpers.nix lib;
in
{
    home.packages = with pkgs; [
        (nemo-with-extensions.override {
            useDefaultExtensions = false;
            extensions = [ nemo-fileroller ];
        })

        file-roller
        p7zip
        rar
    ];

    home.sessionVariables.FILE_MANAGER = "nemo";

    xdg.mimeApps.defaultApplications = helpers.assignMimeFromDesktop fileRollerDesktopPath [ "org.gnome.FileRoller.desktop" ]
        // { "inode/directory" = [ "nemo.desktop" ]; };
}
