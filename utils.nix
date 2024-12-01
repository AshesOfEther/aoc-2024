{ lib }: with lib; rec {
    abs = x: if x < 0 then -x else x;

    eq = x: y: x == y;

    delta = x: y: abs;

    listSum = foldl' add 0;

    sort' = sort lessThan;

    splitLines = s: let
        lines = splitString "\n" s;
        amount = lines;
    in
        take (amount - 1) lines;
}