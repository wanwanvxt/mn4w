final: prev:
    # packages
    (import ./qt6ct.nix final prev)
    // {
        thaimeleon = final.callPackage ./thaimeleon.nix {};
    }

    # functions
    // {
        wrapNeovimUnstable = import ./wrapNeovimUnstable.nix final prev;
    }
