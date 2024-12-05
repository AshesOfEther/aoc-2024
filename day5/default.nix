{
    solution = { input, lib, utils }: with lib; with utils; let
        lines = splitLines input;
        dividerIndex = lists.findFirstIndex (eq "") null lines;
        rules = map (line: { left = toInt (substring 0 2 line); right = toInt (substring 3 2 line); }) (take dividerIndex lines);
        updates = map (line: map toInt (splitString "," line)) (drop (dividerIndex + 1) lines);

        # Graph time
        adjacencyMatrix = mapCartesianProduct ({ left, right }: any (eq { left = left; right = right; }) rules) { left = (range 0 99); right = (range 0 99); };
        getEdge = left: right: elemAt adjacencyMatrix (left * 100 + right);
        checkPair = update: leftIndex: rightIndex: !(getEdge (elemAt update rightIndex) (elemAt update leftIndex));

        checked = partition (update: all (leftIndex:
            all (rightIndex:
                checkPair update leftIndex rightIndex
            ) (range (leftIndex + 1) (length update - 1))
        ) (range 0 (length update - 2))) updates;
        sumMiddles = sumMap (update: elemAt update (length update / 2));
    in {
        part1 = sumMiddles checked.right;

        # Game plan:
        # 
        # 1. For each page, determine if it's in a correct or incorrect position.
        # 2. If the middle is correct, return that.
        # 3. Otherwise, make a list of the incorrect pages, and note which index here corresponds to the middle index of the update.
        # 4. Sort this list, using the adjacency matrix for comparisons.
        part2 = sumMap (update: let
            middleIndex = length update / 2; # Automatically rounds down, so 7 / 2 = 3.
            isPageIncorrect = index: 
                !(all (leftIndex: checkPair update leftIndex index) (range 0 (index - 1))) ||
                !(all (rightIndex: checkPair update index rightIndex) (range (index + 1) (length update - 1)));

            incorrectIndices = filter isPageIncorrect (range 0 (length update - 1));
            incorrectPages = map (elemAt update) incorrectIndices;
            incorrectMiddleIndex = lists.findFirstIndex (eq (elemAt update middleIndex)) null incorrectPages;
            incorrectSorted = sort (a: b: !(getEdge b a)) incorrectPages;
        in if incorrectMiddleIndex == null then
            elemAt update middleIndex
        else
            elemAt incorrectSorted incorrectMiddleIndex
        ) checked.wrong;
    };
    tests = [ {
        input = ''
            47|53
            97|13
            97|61
            97|47
            75|29
            61|13
            75|53
            29|13
            97|29
            53|29
            61|53
            97|53
            61|29
            47|13
            75|47
            97|75
            47|61
            75|61
            47|29
            75|13
            53|13
            
            75,47,61,53,29
            97,61,53,29,13
            75,29,13
            75,97,47,61,53
            61,13,29
            97,13,75,29,47
        '';
        part1 = 143;
        part2 = 123;
    } ];
}