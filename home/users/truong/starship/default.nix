{ config, pkgs, inputs, ... }:
{
    programs.starship = {
        enable = true;
        settings = builtins.fromTOML (builtins.readFile ./bracketed-segments.toml);
    };
}
