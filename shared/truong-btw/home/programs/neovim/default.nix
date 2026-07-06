{ pkgs, config, lib, ... }:
let
    neovimCfg = config.programs.neovim;
    helpers = import ../../helpers.nix lib;
in
{
    config = lib.mkIf config.truong-btw.enable {
        programs.neovim = {
            enable = true;
            extraWrapperArgs = [
                # `romus204/tree-sitter-manager.nvim` plugin requires these
                "--suffix" "PATH" ":" (lib.makeBinPath (with pkgs; [ tree-sitter stdenv.cc ]))
            ];

            defaultEditor = true;
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
        };

        xdg.configFile = lib.optionalAttrs neovimCfg.enable {
            "nvim/init.lua".source = ./config/init.lua;
            "nvim/lua".source      = ./config/lua;
        };

        xdg.mimeApps.defaultApplications =
            lib.optionalAttrs neovimCfg.enable
            (helpers.assignMimes [
                "text/plain"
                "application/x-shellscript"
                "application/x-sh"
                "application/json"
                "application/xml"
            ] [ "nvim.desktop" ]);
    };
}
