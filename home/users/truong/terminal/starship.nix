{lib, ...}: {
    programs.starship = {
        enable = true;
        settings = {
            format = lib.concatStrings [
                "$username"
                "[@](bold bright-green)"
                "$hostname"
                " $directory "
                "$git_branch"
                "$git_status"
                "$cmd_duration"
                "$line_break"
                "$shell "
                "$status"
                "$character "
            ];
            username = {
                format = "[\\[$user]($style)";
                style_user = "bold green";
                style_root = "bold red";
                show_always = true;
            };
            hostname = {
                format = "[$hostname\\]]($style)";
                style = "bold green";
                ssh_only = false;
            };
            directory = {
                format = "[$path]($style)[$read_only]($read_only_style)";
                style = "bold cyan";
                read_only_style = "red";
                read_only = "󰌾";
                truncate_to_repo = false;
            };
            git_branch = {
                format = "[\\[$symbol $branch\\]]($style)";
                style = "bold purple";
                symbol = "";
            };
            git_status = {
                format = "[\\[$all_status$ahead_behind\\]]($style)";
                style = "bold bright-blue";
            };
            cmd_duration = {
                format = "[\\[󱎫 $duration\\]]($style)";
                style = "bold yellow";
            };
            shell = {
                format = "[$indicator]($style)";
                style = "bold white";
                disabled = false;
            };
            status = {
                format = "[\\[$status\\]]($style)";
                style = "bold red";
                disabled = false;
            };
            character = {
                format = "[$symbol]($style)";
                success_symbol = "[](bold green)";
                error_symbol = "[](bold red)";
            };
        };
    };
}
