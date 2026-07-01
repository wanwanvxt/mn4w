final: prev:
let
    qt6ctPatch = prev.fetchurl {
        url = "https://raw.githubusercontent.com/ilya-fedin/nur-repository/a9ec06ecb4d222835f3a870afdb6de35767c2e72/pkgs/qt6ct/qt6ct-shenanigans.patch";
        hash = "sha256-gXtwFPLT4e6Y3Y3NdEltOkSFj6cUOAZMqrqLxatR5Pk=";
    };
in
{
    kdePackages = prev.kdePackages.overrideScope (kdeFinal: kdePrev: {
        qt6ct = kdePrev.qt6ct.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or []) ++ [ qt6ctPatch ];
            buildInputs = (oldAttrs.buildInputs or []) ++ (with kdeFinal; [
                qtdeclarative kconfig kcolorscheme kiconthemes
            ]);
        });
    });
    qt6Packages = prev.qt6Packages.overrideScope (qt6Final: qt6Prev: {
        qt6ct = qt6Prev.qt6ct.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or []) ++ [ qt6ctPatch ];
            buildInputs = (oldAttrs.buildInputs or []) ++ (with qt6Final; with final.kdePackages; [
                qtdeclarative kconfig kcolorscheme kiconthemes
            ]);
        });
    });
}
