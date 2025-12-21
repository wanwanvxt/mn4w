{lib, ...}: {
    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
            format = lib.concatStrings [
                "$username"
                "[@](bright-green)"
                "$hostname"
                "$directory"
                "$git_branch"
                "$git_status"
                "$cmd_duration"
                "$line_break"
                "$shell"
                "$status"
                "$character"
            ];
            username = {
                format = "[\\[$user]($style)";
                style_user = "bright-green";
                show_always = true;
            };
            hostname = {
                format = "[$hostname\\]]($style)";
                style = "bright-green";
                ssh_only = false;
            };
            directory = {
                format = " [\\[$path\\]]($style)[$read_only]($read_only_style) ";
                style = "cyan";
                read_only_style = "red";
                read_only = "[readonly]";
                truncate_to_repo = false;
            };
            git_branch = {
                format = "[\\[$branch\\]]($style)";
                style = "purple";
            };
            git_status = {
                format = "[\\[$all_status$ahead_behind\\]]($style)";
                style = "bright-blue";
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
            cmd_duration = {
                format = " [\\[$duration\\]]($style) ";
                style = "yellow";
            };
            shell = {
                format = "[$indicator]($style) ";
                style = "white";
                disabled = false;
            };
            status = {
                format = "[\\[$status\\]]($style)";
                style = "red";
                disabled = false;
            };
            character = {
                format = "$symbol ";
                success_symbol = "[~>](green)";
                error_symbol = "[>](red)";
            };
        };
    };
}
