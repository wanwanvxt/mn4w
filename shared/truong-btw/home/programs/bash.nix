{ config, lib, ... }:
let
    bashCfg = config.programs.bash;
    fishCfg = config.programs.fish;
in
{
    config = lib.mkIf config.truong-btw.enable {
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
                        "$username@$hostname:$directory ($direnv )$git_branch($git_status)"
                        "$shell $status$character "
                    ];
                    add_newline = false;

                    username = {
                        format = "[$user]($style)";
                        style_user = "green";
                        show_always = true;
                    };
                    hostname = {
                        format = "$hostname";
                        ssh_only = false;
                    };
                    directory = {
                        format = "[$path]($style)[$read_only]($read_only_style)";
                        read_only = "[RO]";
                        style = "cyan";
                        read_only_style = "red";
                        truncate_to_repo = false;
                    };

                    direnv = {
                        disabled = false;
                        format = "[\\[$symbol$loaded/$allowed\\]]($style)";
                        style = "purple";
                    };

                    git_branch = {
                        format = "[\\[$branch\\]]($style)";
                        style = "blue";
                    };
                    git_status = {
                        format = "[\\[$all_status$ahead_behind\\]]($style)";
                        style = "yellow";
                        conflicted = "=";
                        ahead = ">";
                        behind = "<";
                        diverged = "/";
                        up_to_date = "";
                        untracked = "?";
                        stashed = "\$";
                        modified = "!";
                        staged = "+";
                        renamed = "~";
                        deleted = "x";
                        typechanged = "";
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
                        success_symbol = "~>";
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
    };
}
