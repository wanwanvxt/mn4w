final: prev:
    # packages
    (import ./qt6ct.nix final prev)
    // (import ../packages { pkgs = final; })

    # functions
    // {
        wrapNeovimUnstable = import ./wrapNeovimUnstable.nix final prev;
    }
