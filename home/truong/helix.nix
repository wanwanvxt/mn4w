{ config, pkgs, inputs, ... }:
{
    programs.helix = {
        defaultEditor = true;
        settings = {
            theme = "jellybeans";
            editor = {
                true-color = true;
                insert-final-newline = true;
                trim-final-newlines = true;
                trim-trailing-whitespace = true;
                statusline = {
                    left = [
                        "mode" "spinner" "file-absolute-path" "read-only-indicator" "file-modification-indicator"
                        "separator" "version-control" "workspace-diagnostics"
                    ];
                    center = [];
                    right = [ "selections" "register" "position" "file-indent-style" "file-encoding" "file-line-ending" ];
                };
                lsp.enable = true;
                cursor-shape = {
                    normal = "block";
                    insert = "underline";
                    select = "block";
                };
                whitespace.render = "all";
            };
        };
    };
}
