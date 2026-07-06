{ pkgs, config, lib, ... }:
let
    nemoCfg = config.programs.nemo or { enable = false; };
    helpers = import ../../helpers.nix lib;
    pkgXarchiver = pkgs.xarchiver.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];

        postFixup = (oldAttrs.postFixup or "") + ''
            wrapProgram $out/bin/xarchiver \
                --prefix PATH : ${lib.makeBinPath [ pkgs.rar ]}
        '';
    });
in
{
    options.programs.nemo.enable = lib.mkEnableOption "";

    config = lib.mkIf config.truong-btw.enable {
        programs.nemo.enable = true;

        home.packages = lib.optionals nemoCfg.enable [
            pkgs.nemo
            pkgXarchiver
        ];

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

        xdg.dataFile =
        let
            xarchiverBin = lib.getExe pkgXarchiver;
        in
            lib.optionalAttrs nemoCfg.enable {
                "nemo/actions/xarchiver-create.nemo_action".text = ''
                    [Nemo Action]
                    Active=true
                    Name=Create Archive...
                    Comment=Create an archive with Xarchiver
                    Icon-Name=xarchiver

                    Selection=notnone
                    Extensions=any;
                    Quote=double

                    Exec=${xarchiverBin} --compress=%F
                '';
                "nemo/actions/xarchiver-extract-here.nemo_action".text = ''
                    [Nemo Action]
                    Active=true
                    Name=Extract Here
                    Comment=Extract archive here with Xarchiver
                    Icon-Name=xarchiver

                    Selection=notnone
                    Extensions=nodirs;
                    Quote=double

                    Exec=sh -c 'cd %P && for file in %F; do ${xarchiverBin} --ensure-directory "$file"; done'
                '';
                "nemo/actions/xarchiver-extract-to.nemo_action".text = ''
                    [Nemo Action]
                    Active=true
                    Name=Extract To...
                    Comment=Extract archive to another folder with Xarchiver
                    Icon-Name=xarchiver

                    Selection=notnone
                    Extensions=nodirs;
                    Quote=double

                    Exec=sh -c '[ $# -eq 1 ] && exec ${xarchiverBin} --extract "$1" || exec ${xarchiverBin} --multi-extract "$@"' sh %F
                '';
            };
    };
}
