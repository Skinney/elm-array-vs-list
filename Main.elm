module Main exposing (main)

import Benchmark.Runner exposing (BenchmarkProgram, program)
import Benchmark exposing (Benchmark, describe, benchmark)
import Array.Hamt as Array


main : BenchmarkProgram
main =
    program <| suite 1000


suite : Int -> Benchmark
suite n =
    let
        list =
            List.range 0 (n - 1)

        array =
            Array.fromList list

        arrayCons =
            Array.fromList [ -1 ]

        butLastIdx =
            (n - 1)
    in
        describe (toString n ++ " elements")
            [ Benchmark.compare "Remove first"
                "Array"
                (\_ -> Array.slice 1 n array)
                "List"
                (\_ -> List.tail list)
            , Benchmark.compare "Add first"
                "Array"
                (\_ -> Array.append arrayCons array)
                "List"
                (\_ -> -1 :: list)
            , Benchmark.compare "Remove last"
                "List"
                (\_ -> List.take butLastIdx list)
                "Array"
                (\_ -> Array.slice 0 butLastIdx array)
            , Benchmark.compare "Add last"
                "List"
                (\_ -> list ++ [ -1 ])
                "Array"
                (\_ -> Array.push -1 array)
            ]
