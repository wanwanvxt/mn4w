final: prev: {
    kdePackages = prev.kdePackages.overrideScope (kdeFinal: kdePrev: {
        qt6ct = kdePrev.qt6ct.overrideAttrs (oldAttrs: {
            buildInputs =
                (oldAttrs.buildInputs or [])
                ++ (with kdeFinal; [
                    qtdeclarative
                    kconfig
                    kcolorscheme
                    kiconthemes
                ]);

            patches =
                (oldAttrs.patches or [])
                ++ [
                    ./qt6ct-shenanigans.patch
                ];
        });
    });
}
