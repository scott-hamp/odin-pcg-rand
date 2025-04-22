#include "pcgrand.h"

uint32_t pcg32_random(pcg32_random_t *rng)
{
    uint64_t oldstate = rng->state;
    rng->state = oldstate * 6364136223846793005ULL + (rng->inc | 1);
    
	uint32_t xorshifted = (uint32_t)(((oldstate >> 18u) ^ oldstate) >> 27u);
    uint32_t rot = oldstate >> 59u;

    uint32_t n = (xorshifted >> rot) | (xorshifted << ((-rot) & 31));

    return n;
}

void pcg32_seed(pcg32_random_t *rng, uint64_t initstate, uint64_t initseq)
{
	rng->state = 0U;
    rng->inc = (initseq << 1u) | 1u;
    pcg32_random(rng);

    rng->state += initstate;
    pcg32_random(rng);
}

void pcg32_seed_time(pcg32_random_t* rng)
{
	uint64_t initstate = (uint64_t)time(NULL);
	uint64_t initseq = (uint64_t)rand();
	
	pcg32_seed(rng, initstate, initseq);
}

float pcg32_random_float(pcg32_random_t *rng)
{
    float f = (float)pcg32_random(rng) / (float)UINT32_MAX;

    return f;
}

int pcg32_random_int(pcg32_random_t* rng, int from, int to)
{
    if (from >= to) return from;

    int i = from + (int)(pcg32_random_float(rng) * (to - from + 1));

    return i;
}