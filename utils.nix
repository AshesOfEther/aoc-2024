{ lib }: with lib; {
    splitLines = s: let
        lines = splitString "\n" s;
        amount = lines;
    in
        take (amount - 1) lines;
}