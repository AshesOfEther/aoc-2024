{ lib }: {
    splitLines = s: let
        lines = lib.splitString "\n" s;
        length = lib.length lines;
    in
        lib.take (length - 1) lines;
}