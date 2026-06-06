{ pkgs, ... }: {
    time.timeZone = "Asia/Ho_Chi_Minh";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        keyMap = "us";
        font = "ter-132n";
        packages = [ pkgs.terminus_font ];
    };
}
