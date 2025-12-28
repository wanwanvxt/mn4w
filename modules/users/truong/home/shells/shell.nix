{pkgs, ...}: {
    programs = {
        bash = {
            enable = true;
            enableCompletion = true;
        };
        fish = {
            enable = true;
            generateCompletions = true;
            interactiveShellInit = ''
                set -p fish_complete_path ${pkgs.fish}/share/fish/completions
                set -g fish_greeting
            '';
        };
    };

    home = {
        shell = {
            enableBashIntegration = true;
            enableFishIntegration = true;
        };
        packages = with pkgs; [
            bash-language-server
            fish-lsp
        ];
    };
}
