{pkgs, ...}: {
    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        nerd-fonts._0xproto
    ];

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            serif = ["Noto Serif"];
            sansSerif = ["Noto Sans"];
            monospace = ["0xProto Nerd Font" "Noto Sans Mono"];
            emoji = ["Noto Color Emoji"];
        };
    };
}
