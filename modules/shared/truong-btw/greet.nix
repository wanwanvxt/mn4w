{ pkgs, ... }: {
    programs.uwsm.enable = true;

    environment.systemPackages = [ pkgs.tuigreet ];
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = ''
                    tuigreet --time --remember --remember-session --asterisks \
                    --cmd 'uwsm start default'
                '';
                user = "greeter";
            };
        };
    };
}
