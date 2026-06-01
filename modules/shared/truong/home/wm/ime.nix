{ pkgs, config, lib, ... }:
let
    imeCfg = config.i18n.inputMethod;
in
{
    config = lib.mkMerge [
        {
            i18n.inputMethod = {
                enable = true;
                type = "fcitx5";
                fcitx5 = {
                    waylandFrontend = true;
                    addons = [ pkgs.fcitx5-bamboo ];
                    settings = {
                        inputMethod = {
                            GroupOrder."0" = "Default";
                            "Groups/0" = {
                                Name = "Default";
                                "Default Layout" = "us";
                                DefaultIM = "bamboo";
                            };
                            "Groups/0/Items/0".Name = "keyboard-us";
                            "Groups/0/Items/1".Name = "bamboo";
                        };
                        globalOptions = {
                            "Hotkey/TriggerKeys"."0" = "Super+space";
                        };
                        addons = {
                            bamboo.globalSection = {
                                InputMethod = "Telex";
                                OutputCharset = "Unicode";
                                SpellCheck = "True";
                                AutoNonVnRestore = "True";
                                ModernStyle = "True";
                                FreeMarking = "True";
                                DisplayUnderline = "True";
                            };
                        };
                    };
                };
            };
        }

        # fix fcitx5 does not work properly with some apps. Eg: xdg-desktop-portal-gtk
        (lib.mkIf (imeCfg.enable && imeCfg.type == "fcitx5") {
            home.sessionVariables = {
                GTK_IM_MODULE = "fcitx";
                QT_IM_MODULE = "fcitx";
            };
            systemd.user.sessionVariables = {
                GTK_IM_MODULE = "fcitx";
                QT_IM_MODULE = "fcitx";
            };
        })
    ];
}
