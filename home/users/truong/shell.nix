{pkgs, ...}: {
    programs = {
        bash = {
            enable = true;
            enableCompletion = true;
        };
        fish = {
            enable = true;
            generateCompletions = true;
            interactiveShellInit = "set -p fish_complete_path ${pkgs.fish}/share/fish/completions";
        };
    };

    home.shell = {
        enableBashIntegration = true;
        enableFishIntegration = true;
    };
}
