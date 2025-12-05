{ pkgs, ... }:
{
    time.timeZone = "Asia/Ho_Chi_Minh";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        keyMap = "us";
        packages = with pkgs; [ terminus_font ];
        font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";
    };
}
