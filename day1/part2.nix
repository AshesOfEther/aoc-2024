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
    solution = { lib, input, ... }: with lib; let
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
        # Multiply the left numbers by the amount of occurences in the right list.
        leftMultiplied = map (x: x * count (y: x == y) right) left;
        # Add that together.
        sum = foldl' (a: b: a + b) 0 leftMultiplied;
    in sum;
}