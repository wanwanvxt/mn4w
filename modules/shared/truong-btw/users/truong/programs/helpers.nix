lib: rec {
    assignMime = mimeList: desktopList:
        let
            mimeList_ =
                if builtins.isList mimeList then mimeList
                else lib.strings.splitString ";" mimeList;
            cleanMimeList = lib.lists.filter (x: x != "") mimeList_;
        in
            builtins.listToAttrs (map (mime: {
                name = mime;
                value = desktopList;
            }) cleanMimeList);

    assignMimeFromDesktop = desktopPath: desktopList:
        let
            desktopContent = builtins.readFile desktopPath;

            lines = lib.strings.splitString "\n" desktopContent;
            mimeLine = lib.lists.findFirst
                (line: lib.strings.hasPrefix "MimeType=" line) "" lines;

            mimeList = (lib.strings.removePrefix "MimeType=" mimeLine);
        in
            assignMime mimeList desktopList;
}
