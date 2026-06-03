final: prev: {
    thaimeleon = final.rustPlatform.buildRustPackage rec {
        pname = "thaimeleon";
        version = "0.1.2";

        src = final.fetchFromCodeberg {
            owner = "thairanaru";
            repo = "thaimeleon";
            rev = "v${version}";
            hash = "sha256-eVDTysIe+jZ9F/x/GMIcuodqgslEoNMd2/n8Ze03vdk=";
        };

        cargoHash = "sha256-wEs0P/zBWYBilen0/jgx7uyrYss3ipabb2/XaKfocfY=";

        meta = {
            description = "Automatically generate a color scheme from a wallpaper!";
            homepage = "https://codeberg.org/thairanaru/thaimeleon";
            license = final.lib.licenses.agpl3Only;
            mainProgram = "thaimeleon";
        };
    };
}
