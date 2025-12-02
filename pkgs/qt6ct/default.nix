{ pkgs }:
pkgs.kdePackages.qt6ct.overrideAttrs(oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ (
        with pkgs.kdePackages; [ qtdeclarative kconfig kcolorscheme kiconthemes ]
    );

    patches = [ ./qt6ct-shenanigans.patch ];
})
