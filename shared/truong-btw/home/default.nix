{ osConfig, lib, ... }: {
    config = {
        home.stateVersion = osConfig.system.stateVersion;
        truong-btw.enable = osConfig.truong-btw.enable;
    };

    options.truong-btw.enable = lib.mkEnableOption "";
    imports = [
        ./xdg.nix
        ./programs
        ./gui
    ];
}
