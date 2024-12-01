{
    tests = [
        {
            input = ''
                3   4
                4   3
                2   5
                1   3
                3   9
                3   3
            '';
            output = 31;
        }
    ];
    solution = { lib, input, ... }: let
        # Get list of lines.
        lines' = lib.splitString "\n" input;
        # Remove trailing empty line.
        lines = lib.filter (line: line != "") lines';
        # Parse each line into a pair of numbers.
        pairs = lib.map (line: lib.splitString "   " line) lines;
        # Get a list of the left numbers.
        left = lib.map (pair: lib.toInt (lib.elemAt pair 0)) pairs;
        # Get a list of the right numbers.
        right = lib.map (pair: lib.toInt (lib.elemAt pair 1)) pairs;
        # Multiply the left numbers by the amount of occurences in the right list.
        leftMultiplied = lib.map (x: x * lib.count (y: x == y) right) left;
        # Add that together.
        sum = lib.foldl' (a: b: a + b) 0 leftMultiplied;
    in sum;
}