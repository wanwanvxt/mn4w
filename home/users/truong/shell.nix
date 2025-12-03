{ config, pkgs, inputs, ... }:
{
    xdg.configFile."fish/fishline".source = inputs.fishline;

    programs = {
        bash = {
            enable = true;
            enableCompletion =  true;
        };
        fish = {
            enable = true;
            generateCompletions = true;
            interactiveShellInit = ''
                set -p fish_complete_path ${pkgs.fish}/share/fish/completions

                set FLINE_PATH $XDG_CONFIG_HOME/fish/fishline
                source $FLINE_PATH/init.fish
            '';
            functions = {
                fish_prompt = ''
                    set FLCLR_EXECTIME_BG yellow
                    set FLCLR_EXECTIME_FG black

                    fishline -s $status clock userhost fullpwd write git n exectime sigstatus root space
                '';
            };
        };
    };

    home.shell = {
        enableBashIntegration = true;
        enableFishIntegration = true;
    };
}
