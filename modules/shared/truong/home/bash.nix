{ config, lib, ... }:
let
    bashCfg = config.programs.bash;
    fishCfg = config.programs.fish;
in
{
    home.shell = {
        enableBashIntegration = bashCfg.enable;
        enableFishIntegration = fishCfg.enable;
    };

    programs = {
        bash = {
            enable = true;
            enableCompletion = true;
        };

        fish = {
            enable = true;
            generateCompletions = true;
            shellInit = ''
                set -g fish_greeting
            '';
        };
        kitty.settings.shell = "fish";

        fzf = {
            enable = true;
            defaultOptions = [ "--border" "--highlight-line" ];
        };

        starship = {
            enable = true;
            settings = {
                format = lib.strings.concatStringsSep "\n" [
                    "$username@$hostname:$directory $nix_shell$git_branch$git_status"
                    "$shell $status$character "
                ];
                add_newline = false;

                username = {
                    format = "[$user]($style)";
                    style_user = "green";
                    show_always = true;
                };
                hostname = {
                    format = "[$hostname]($style)";
                    style = "green";
                    ssh_only = false;
                };
                directory = {
                    format = "[$path]($style)[$read_only]($read_only_style)";
                    read_only = "[RO]";
                    style = "blue";
                    read_only_style = "red";
                    truncate_to_repo = false;
                };

                nix_shell = {
                    format = "[\\[$state( $name)\\]]($style) ";
                    style = "purple";
                    impure_msg = "impure";
                    pure_msg = "pure";
                    unknown_msg = "unknown";
                };

                git_branch = {
                    format = "[\\[$branch\\]]($style)";
                    style = "yellow";
                };
                git_status = {
                    format = "([\\[$all_status$ahead_behind\\]]($style))";
                    style = "cyan";
                    conflicted = "=";
                    ahead = ">";
                    behind = "<";
                    diverged = "/";
                    up_to_date = "";
                    untracked = "?";
                    stashed = "$";
                    modified = "!";
                    staged = "+";
                    renamed = "~";
                    deleted = "x";
                    typechanged = "%";
                };

                shell = {
                    disabled = false;
                    format = "$indicator";
                };
                status = {
                    disabled = false;
                    format = "[\\[$status\\]]($style)";
                    style = "red";
                };
                character = {
                    format = "$symbol";
                    success_symbol = "[~>](green)";
                    error_symbol = "[>](red)";
                };
            };
        };


        direnv = {
            enable = true;
            nix-direnv.enable = true;
            silent = true;
        };
    };
}
