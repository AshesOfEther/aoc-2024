{
    solution = { input, lib, utils }: with lib; with utils; let
        parts = split "mul[(]([0-9]{1,3}),([0-9]{1,3})[)]" input;
        processMul = list: toInt (elemAt list 0) * toInt (elemAt list 1);
    in {
        part1 = sum (imap0 (i: list:
            if mod i 2 == 1 then
                processMul list
            else 0
        ) parts);
        
        part2 = (foldl' ({ do, isMul, sum }: part:
            if isMul then
                if do then
                    { do = do; isMul = false; sum = sum + processMul part; }
                else
                    { do = do; isMul = false; sum = sum; }
            else
                { do =
                    if hasInfix "do()" part then true
                    else if hasInfix "don't()" part then false
                    else do; 
                isMul = true; sum = sum; }
        ) { do = true; isMul = false; sum = 0; } parts).sum;
    };

    tests = [ {
        input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
        part1 = 161;
        part2 = null;
    } {
        input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";
        part1 = null;
        part2 = 48;
    }];
}