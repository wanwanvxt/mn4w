final: prev:
    (import ./qt6ct.nix final prev)
    // {
        thaimeleon = final.callPackage ./thaimeleon.nix {};
    }
