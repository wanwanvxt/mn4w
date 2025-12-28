{...}: {
    imports = [
        # edtiros
        ./helix.nix

        # terminals
        ./kitty.nix

        # files
        ./dolphin.nix

        # browsers
        ./firefox.nix

        # others
        ./top.nix
        ./vesktop.nix
        ./others.nix
    ];
}
