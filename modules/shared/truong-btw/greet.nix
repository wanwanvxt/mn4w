{ pkgs, lib, ... }: {
    programs.uwsm.enable = true;

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = ''
                    ${lib.getExe pkgs.tuigreet} --time --remember --remember-session --asterisks \
                    --cmd 'uwsm start default'
                '';
                user = "greeter";
            };
        };
    };
}
