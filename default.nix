let
    pkgs = import <nixpkgs> {};
    lib = pkgs.lib;
    utils = import ./utils.nix { lib = lib; };
in
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