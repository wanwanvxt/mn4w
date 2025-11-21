{ config, pkgs, inputs, ... }:
{
    programs.git = {
        lfs.enable = true;
        settings = {
            user = {
                name = "Vũ Xuân Trường";
                email = "wanwan.vxt@gmail.com";
            };
        };
    };
}
