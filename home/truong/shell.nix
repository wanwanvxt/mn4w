{ config, pkgs, inputs, ... }:
{
    programs = {
        bash.enableCompletion =  true;
        fish.generateCompletions = true;
    };

    home.shell = {
        enableBashIntegration = true;
        enableFishIntegration = true;
    };
}
