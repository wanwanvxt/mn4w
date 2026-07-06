final: prev:

(unwrapped: args:
    (prev.wrapNeovimUnstable unwrapped args).overrideAttrs (oldAttrs: {
        postBuild = (oldAttrs.postBuild or "") + ''
            substituteInPlace $out/share/applications/nvim.desktop \
                --replace-warn "Name=Neovim wrapper" "Name=Neovim"
        '';
    })
)
