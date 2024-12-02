{ lib }: with lib; rec {
    abs = x: if x < 0 then -x else x;

    eq = x: y: x == y;

    delta = x: y: abs;

    greaterThan = x: y: x > y;

    isBetweenInclusive = a: b: x: a <= x && x <= b;

    isNegative = lessThan 0;

    isPositive = greaterThan 0;

    listSum = foldl' add 0;

    pipe' = list: initial: pipe initial list;

    removeAt = index: list: take index list ++ drop (index + 1) list;

    sort' = sort lessThan;

    splitLines = s: let
        lines = splitString "\n" s;
        amount = length lines;
    in
        take (amount - 1) lines;
}