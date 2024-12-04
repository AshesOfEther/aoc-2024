{
    solution = { input, lib, utils }: with lib; with utils; let
        grid = map stringToCharacters (splitLines input);
        width = length (elemAt grid 0);
        height = length grid;
        getCell = x: y: if
            0 <= x && x < width &&
            0 <= y && y < height
        then 
            elemAt (elemAt grid y) x
        else null;
        checkCellsWith = f: foldl' (acc: y:
            acc + foldl' (rowAcc: x:
                rowAcc + f x y
            ) 0 (range 0 (width - 1))
        ) 0 (range 0 (height - 1));
    in {
        part1 = checkCellsWith (x: y: let
            checkDirection = xDir: yDir: let
                getIndex = i: getCell (x + xDir * i) (y + yDir * i);
            in
                oneIf (getIndex 1 == "M" && getIndex 2 == "A" && getIndex 3 == "S");
        in if getCell x y == "X" then
            checkDirection   1   0  +
            checkDirection (-1)  0  +
            checkDirection   0   1  +
            checkDirection   0 (-1) +
            checkDirection   1   1  +
            checkDirection   1 (-1) +
            checkDirection (-1)(-1) +
            checkDirection (-1)  1
        else 0);

        part2 = checkCellsWith (x: y: let
            checkMas = xOffSet: yOffSet: let
                first = getCell (x - xOffSet) (y - yOffSet);
                second = getCell (x + xOffSet) (y + yOffSet);
            in first == "M" && second == "S" || first == "S" && second == "M";
        in oneIf (getCell (x) (y) == "A" && checkMas 1 1 && checkMas (-1) 1));
    };

    tests = [ {
        input = ''
            MMMSXXMASM
            MSAMXMSMSA
            AMXSXMAAMM
            MSAMASMSMX
            XMASAMXAMM
            XXAMMXXAMA
            SMSMSASXSS
            SAXAMASAAA
            MAMMMXMMMM
            MXMXAXMASX
        '';
        part1 = 18;
        part2 = 9;
    } ];
}