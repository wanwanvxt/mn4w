{ ... }:
{
    programs.vesktop = {
        enable = true;
        settings = {
            discordBranch = "stable";
            transparencyOption = "none";
            tray = true;
            minimizeToTray = true;
            autoStartMinimized = false;
            openLinksWithElectron = false;
            staticTitle = false;
            enableMenu = false;
            disableSmoothScroll = false;
            hardwareAcceleration = true;
            hardwareVideoAcceleration = true;
            arRPC = true;
            appBadge = true;
            disableMinSize = true;
            clickTrayToShowHide = true;
            customTitleBar = false;
            enableSplashScreen = false;
        };
    };
}
