{
    solution = { input, lib, utils, ... }: with lib; with utils; let 
        # Get list of lines.
        lines' = splitString "\n" input;

        # Remove trailing empty line.
        lines = filter (line: line != "") lines';

        # Parse each line into a pair of numbers.
        pairs = map (line: splitString "   " line) lines;

        # Get a list of the left numbers.
        left = map (pair: toInt (elemAt pair 0)) pairs;

        # Get a list of the right numbers.
        right = map (pair: toInt (elemAt pair 1)) pairs;
    in {
        part1 = let 
            # Sort the two lists.
            leftSorted = sortOn (x: x) left;
            rightSorted = sortOn (x: x) right;

            # Calculate the distances.
            abs = x: if x < 0 then -x else x;
            distances = zipListsWith (a: b: abs (a - b)) leftSorted rightSorted;

            # Add the distances together.
            sum = foldl' (a: b: a + b) 0 distances;
        in sum;

        part2 = let
            # Multiply the left numbers by the amount of occurences in the right list.
            leftMultiplied = map (x: x * count (y: x == y) right) left;

            # Add that together.
            sum = foldl' (a: b: a + b) 0 leftMultiplied;
        in sum;
    };

    tests = [ {
        input = ''
            3   4
            4   3
            2   5
            1   3
            3   9
            3   3
        '';
        part1 = 11;
        part2 = 31;
    } ];
}