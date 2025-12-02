{ config, pkgs, inputs, ... }:
{
    programs.helix = {
        defaultEditor = true;
        settings = {
            theme = "dark_plus";
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
                    right = [
                        "primary-selection-length" "register" "position"
                        "file-indent-style" "file-encoding" "file-line-ending"
                    ];
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
