let
    flake = builtins.getFlake (toString ./.);
in
import flake.inputs.nixpkgs {
    system = builtins.currentSystem;
    overlays = [ flake.outputs.overlays.default ];
}
