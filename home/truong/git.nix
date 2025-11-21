{ config, pkgs, inputs, ... }:
{
    programs.git = {
        lfs.enable = true;
        settings = {
            init.defaultBranch = "main";
            user = {
                name = "Vũ Xuân Trường";
                email = "wanwan.vxt@gmail.com";
            };
        };
    };
}
