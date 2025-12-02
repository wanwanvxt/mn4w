final: prev:
{
    kdePackages = prev.kdePackages.overrideScope (kdeFinal: kdePrev: {
        qt6ct = kdePrev.qt6ct.overrideAttrs (oldAttrs: {
            buildInputs = oldAttrs.buildInputs ++ (
                with final; with final.kdePackages; [ qtdeclarative kconfig kcolorscheme kiconthemes ]
            );
            patches = [ ./qt6ct-shenanigans.patch ];
        });
    });
}
