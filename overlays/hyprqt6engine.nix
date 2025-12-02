final: prev:
{
    hyprqt6engine = prev.hyprqt6engine.overrideAttrs (oldAttrs: {
        buildInputs = (oldAttrs.buildInputs or []) ++
        (with prev.kdePackages; [ qtdeclarative kconfig kcolorscheme kiconthemes ]);

        nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
            prev.kdePackages.extra-cmake-modules
        ];
    });
}
