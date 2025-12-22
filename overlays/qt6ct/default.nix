final: prev: {
    kdePackages = prev.kdePackages.overrideScope (kdeFinal: kdePrev: {
        qt6ct = kdePrev.qt6ct.overrideAttrs (oldAttrs: rec {
            version = "0.11";
            src = prev.fetchFromGitLab {
                domain = "www.opencode.net";
                owner = "trialuser";
                repo = "qt6ct";
                tag = version;
                hash = "sha256-aQmqLpM0vogMsYaDS9OeKVI3N53uY4NBC4FF10hK8Uw=";
            };

            buildInputs =
                (oldAttrs.buildInputs or [])
                ++ (with kdeFinal; [
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
