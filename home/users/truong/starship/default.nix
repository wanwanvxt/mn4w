{ config, pkgs, inputs, ... }:
let
    bracketedSegmentsCfg = builtins.fromTOML (builtins.readFile ./bracketed-segments.toml);
in
{
    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
            username = bracketedSegmentsCfg.username // {
                show_always = true;
            };
            hostname = bracketedSegmentsCfg.hostname // {
                ssh_only = false;
            };
            directory = bracketedSegmentsCfg.directory // {
                truncate_to_repo = false;
            };
            time = bracketedSegmentsCfg.time // {
                disabled = false;
            };
            status = bracketedSegmentsCfg.status // {
                disabled = false;
            };
            shell = bracketedSegmentsCfg.shell // {
                disabled = false;
            };
        } // bracketedSegmentsCfg;
    };
}
