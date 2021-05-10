#ifndef MATH_H
#define MATH_H


#include <stdint.h>


typedef float  float32_t;
typedef double float64_t;

#define PI 3.14159265358979323846264338327950

float64_t sin(float64_t x);
float64_t cos(float64_t x);

// Random
#define RAND_MAX 4294967295
void seed(uint32_t s);
uint32_t rand();


#endif // !MATH_H
