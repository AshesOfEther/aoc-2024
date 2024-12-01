let
    pkgs = import <nixpkgs> {};
    utils = import ./utils.nix;

    day = ./day1;
    part1 = import (day + /part1.nix) { utils = utils; };
    part2 = import (day + /part2.nix) { utils = utils; };
    input = pkgs.lib.readFile (day + /input.txt);

in
    part1.solution {
        #input = (builtins.elemAt day1.tests 0).input;
        input = input;
        lib = pkgs.lib;
    }