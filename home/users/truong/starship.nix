{ lib, ... }:
{
    programs.starship = {
        enable = true;
        settings = {
            format = lib.concatStrings [
                "$username"
                "[@](bold bright-green)"
                "$hostname"
                "$directory"
                "$git_branch$git_status"
                "$cmd_duration"
                "$line_break"
                "$shell"
                "$status"
                "$character"
            ];
            palette = "green";
            palettes.green = {
                green_1 = "#9ece6a";
                green_2 = "#8eb95f";
                green_3 = "#7ea454";
                green_4 = "#6e904a";
                green_5 = "#5e7b3f";
                green_6 = "#4f6735";
                green_7 = "#3f522a";
                green_8 = "#2f3d1f";
                green_9 = "#1f2915";
            };
            username =  {
                format = "[\\[$user]($style)";
                style_user = "bold green";
                style_root = "bold red";
                show_always = true;
            };
            hostname = {
                format = "[$hostname\\]]($style) ";
                style = "bold green";
                ssh_only = false;
            };
            directory = {
                format = "[$path]($style)[$read_only]($read_only_style) ";
                style = "bold cyan";
                read_only_style = "red";
                read_only = "󰌾";
                truncate_to_repo = false;
            };
            git_branch = {
                format = "[\\[$symbol $branch]($style) ";
                style = "bold purple";
                symbol = "";
            };
            git_status = {
                format = "[$all_status$ahead_behind]($style)[\\]](bold purple) ";
                style = "bold red";
            };
            cmd_duration = {
                format = "[\\[󱎫 $duration\\]]($style)";
                style = "bold yellow";
                show_milliseconds = true;
            };
            shell = {
                format = "[$indicator]($style) ";
                style = "bold white";
                disabled = false;
            };
            status = {
                format = "[\\[$status\\]]($style)";
                style = "bold red";
                disabled = false;
            };
            character = {
                format = "[$symbol]($style) ";
                success_symbol = "[](bold green)";
                error_symbol = "[](bold red)";
            };
        };
    };
}
