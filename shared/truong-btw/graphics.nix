{ config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };

        hardware.nvidia = {
            open = true;
            modesetting.enable = true;
            prime.offload = {
                enable = true;
                enableOffloadCmd = true;
            };
        };
    };
}
