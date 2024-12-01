let
    pkgs = import <nixpkgs> {};
    lib = pkgs.lib;
    utils = import ./utils.nix { lib = lib; };

    day = ./day1;
    part1 = import (day + /part1.nix) { utils = utils; };
    part2 = import (day + /part2.nix) { utils = utils; };
    input = pkgs.lib.readFile (day + /input.txt);


in
    #lib.listToAttrs (map (num: let name = "day${builtins.toString num}"; in {
    #    name = name;
    #    value = import ./${name};
    #}) (lib.range 1 25))
    lib.pipe (builtins.readDir ./.) [
        (lib.filterAttrs (name: type: lib.hasPrefix "day" name && type == "directory"))
        (lib.mapAttrs (name: _: let
            day = (import ./${name});
            invoke = input: day.solution {
                input = input;
                lib = pkgs.lib;
                utils = utils;
            };
            part = num': let num = toString num'; in {
                tests = map (test: (invoke test.input)."part${num}" == test."part${num}") day.tests;
                result = (invoke (lib.readFile ./${name}/input.txt))."part${num}";
            };
        in { part1 = part 1; part2 = part 2; }))
    ]
    
    #part1.solution {
    #    #input = (builtins.elemAt day1.tests 0).input;
    #    input = input;
    #    lib = pkgs.lib;
    #    utils = utils;
    #}