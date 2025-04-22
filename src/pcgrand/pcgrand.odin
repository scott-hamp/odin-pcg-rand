package pcgrand

import "core:os"

when os.OS == .Linux {
    foreign import pcgrand "libpcgrand.so"
} else {
    foreign import pcgrand "libpcgrand.a"
}

// Struct to hold the state and increment of a PCG32 random number generator.
pcg32_random_t :: struct {
    state : u64,
    inc   : u64,
}

foreign pcgrand {

    // Generate the next state.
    pcg32_random            :: proc(ptr: ^pcg32_random_t) -> u32 ---
    
    // Seed the generator with a 64-bit state and increment.
    pcg32_seed              :: proc(ptr: ^pcg32_random_t, state: u64, increment: u64) -> u32 ---
    
    // Seet the generator with the current time.
    pcg32_seed_time         :: proc(ptr: ^pcg32_random_t) -> u32 ---
    
    // Generate a random float from 0.0 to 1.0.
    pcg32_random_float      :: proc(ptr: ^pcg32_random_t) -> f32 ---

    // Generate a random int.
    pcg32_random_int        :: proc(ptr: ^pcg32_random_t, from: int, to: int) -> int ---
}