let
    flake = builtins.getFlake (toString ./.);
in
import flake.inputs.nixpkgs {
    overlays = [ flake.outputs.overlays.default ];
}
