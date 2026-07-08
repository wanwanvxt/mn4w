{
    lib,
    stdenv,
    fetchFromGitHub,
    autoreconfHook,
    pkg-config,
    perl,
    glib,
    libcanberra,
}:

stdenv.mkDerivation rec {
    pname = "xdg-sound";
    version = "1.0";

    src = fetchFromGitHub {
        owner = "bbidulock";
        repo = "xdg-sound";
        rev = version;
        hash = "sha256-VnjmcMaU6k7sj8y8F5o9kAhpKJCL19YI6fmnsa48bL0=";
    };

    nativeBuildInputs = [
        autoreconfHook
        pkg-config
        perl
    ];

    buildInputs = [
        glib
        libcanberra
    ];

    meta = {
        description = "XDG compliant sound tools and utilities";
        homepage = "https://github.com/bbidulock/xdg-sound";
        license = lib.licenses.gpl3Plus;
        platforms = lib.platforms.linux;
        mainProgram = "xdg-play";
    };
}
