package main

import "core:c"
import "core:fmt"
import "core:strings"
import pcg "pcgrand"

main :: proc() {

    // Create the PCG object:
    pcg32r := new(pcg.pcg32_random_t)
    defer free(pcg32r)

    // Seed it:
    pcg.pcg32_seed_time(pcg32r)
    // Or: pcg.pcg32_seed(pcg32r, 0x853c49e6748fea9b, 0x9e3779b97f4a7c15)

    // Generate 100 random floats:

    for i := 0; i < 100; i += 1 {
        f := pcg.pcg32_random_float(pcg32r)
        fmt.printfln("Random float: %f", f)
    }

    // Generate 100 random ints:

    for i := 0; i < 100; i += 1 {
        ii := pcg.pcg32_random_int(pcg32r, 1, 100)
        fmt.printfln("Random int (1-100): %d", ii)
    }
}