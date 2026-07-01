{ config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
    };
}
