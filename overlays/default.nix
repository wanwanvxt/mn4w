final: prev:
    # packages
    (import ./qt6ct.nix final prev)
    // {
        thaimeleon = final.callPackage ../packages/thaimeleon.nix {};
        xdg-sound = final.callPackage ../packages/xdg-sound.nix {};
    }

    # functions
    // {
        wrapNeovimUnstable = import ./wrapNeovimUnstable.nix final prev;
    }
