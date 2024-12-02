{
    solution = { input, lib, utils }: with lib; with utils; let
        lines = splitLines input;
        reports = map (pipe' [ (splitString " ") (map toInt) ]) lines;
        isReportSafe = (pipe' [
            (report: zipListsWith sub report (drop 1 report))
            (results:
                (all isNegative results || all isPositive results) &&
                all (pipe' [abs (isBetweenInclusive 1 3)] ) results
            )
        ] );
    in {
        part1 = count isReportSafe reports;

        part2 = count (report:
            any (index: isReportSafe (removeAt index report)) (range 0 (length report))
        ) reports;
    };

    tests = [ {
        input = ''
            7 6 4 2 1
            1 2 7 8 9
            9 7 6 2 1
            1 3 2 4 5
            8 6 4 4 1
            1 3 6 7 9
        '';
        part1 = 2;
        part2 = 4;
    } ];
}