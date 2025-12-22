{
    osConfig,
    pkgs,
    ...
}: {
    home.stateVersion = osConfig.system.stateVersion;

    imports = [
        ./general
        ./terminal
        ./vcs
        ./files
        ./editors
        ./tools
        ./others
    ];
}
