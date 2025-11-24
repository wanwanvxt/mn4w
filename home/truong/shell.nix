{ config, pkgs, inputs, ... }:
{
    xdg.configFile."fish/fishline".source = inputs.fishline;

    programs = {
        bash.enableCompletion =  true;
        fish = {
            generateCompletions = true;
            interactiveShellInit = ''
                set FLINE_PATH $XDG_CONFIG_HOME/fish/fishline
                source $FLINE_PATH/init.fish
            '';
        };
    };

    home.shell = {
        enableBashIntegration = true;
        enableFishIntegration = true;
    };
}
