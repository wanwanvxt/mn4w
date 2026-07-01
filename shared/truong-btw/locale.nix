{ pkgs, config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        time.timeZone = "Asia/Ho_Chi_Minh";
        i18n.defaultLocale = "en_US.UTF-8";
        console = {
            keyMap = "us";
            font = "ter-124b";
            packages = [ pkgs.terminus_font ];
        };
    };
}
