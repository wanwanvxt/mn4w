{...}: {
    programs.fzf = {
        enable = true;
        defaultOptions = [
            "--border"
            "--highlight-line"
        ];
    };
}
