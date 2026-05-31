final: prev: {
    materia-kde-theme = prev.materia-kde-theme.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
            find $out -name "*.kvconfig" -exec sed -i -E 's/iconless_([a-zA-Z0-9_]+)=true/iconless_\1=false/g' {} +
        '';
    });
}
