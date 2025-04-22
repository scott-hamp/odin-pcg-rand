#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

// PCG32 state and increment struct
typedef struct pcg32_random_t {
    uint64_t state;
    uint64_t inc;
} pcg32_random_t;

// PCG32 output
uint32_t pcg32_random(pcg32_random_t* rng);

// Seed the PCG32 RNG
void pcg32_seed(pcg32_random_t* rng, uint64_t initstate, uint64_t initseq);
void pcg32_seed_time(pcg32_random_t* rng);

// Generate a random float from 0.0 to 1.0
float pcg32_random_float(pcg32_random_t* rng);

// Generate a random int.
int pcg32_random_int(pcg32_random_t* rng, int from, int to);