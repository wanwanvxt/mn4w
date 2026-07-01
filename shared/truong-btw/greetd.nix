{ config, pkgs, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        programs.uwsm.enable = true;

        services.greetd = {
            enable = true;
            settings = {
                default_session = {
                    command = "${lib.getExe pkgs.tuigreet} --time --cmd 'uwsm start default'";
                    user = "greeter";
                };
            };
        };
    };
}
