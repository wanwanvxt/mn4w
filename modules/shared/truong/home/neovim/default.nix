{ pkgs, config, lib, ... }:
let
    neovimCfg = config.programs.neovim;
    neovimDesktopPath = "${neovimCfg.finalPackage}/share/applications/nvim.desktop";
    helpers = import ../helpers.nix lib;
in
{
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

    xdg.configFile = {
        "nvim/init.lua".source = ./config/init.lua;
        "nvim/lua".source      = ./config/lua;
    };

    xdg.mimeApps.defaultApplications = helpers.assignMimeFromDesktop neovimDesktopPath [ "nvim.desktop" ];
}
