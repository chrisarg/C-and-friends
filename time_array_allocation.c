#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <omp.h>
#include <immintrin.h>
#include <stddef.h>

#define BILLION 1000000000L;

void *memset_avx2(void *s, int c, size_t n)
{
    unsigned char *p = (unsigned char *)s;
    __m256i value = _mm256_set1_epi8((unsigned char)c);

    size_t i;
    for (i = 0; i + 31 < n; i += 32)
    {
        _mm256_storeu_si256((__m256i *)(p + i), value);
    }

    for (; i < n; i++)
    {
        p[i] = (unsigned char)c;
    }

    return s;
}

double time_allocation_and_initialization(size_t length, char initial_value)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)malloc(length * sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    memset_avx2(array, initial_value, length);
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_callocation_and_initialization(size_t length, char initial_value)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)calloc(length, sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    memset_avx2(array, initial_value, length);
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_allocation_and_initialization_loop(size_t length, char initial_value)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)malloc(length * sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    for (size_t i = 0; i < length; i++)
    {
        array[i] = initial_value;
    }
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_callocation_and_initialization_loop(size_t length, char initial_value)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)calloc(length, sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    for (size_t i = 0; i < length; i++)
    {
        array[i] = initial_value;
    }
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_allocation_and_initialization_openmp_simd(size_t length, char initial_value)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)malloc(length * sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
#pragma omp parallel for simd
    for (size_t i = 0; i < length; i++)
    {
        array[i] = initial_value;
    }
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_callocation_and_initialization_openmp_simd(size_t length, char initial_value)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)calloc(length, sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
#pragma omp parallel for simd
    for (size_t i = 0; i < length; i++)
    {
        array[i] = initial_value;
    }
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_allocation(size_t length)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)malloc(length * sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

double time_callocation(size_t length)
{
    struct timespec start, stop;
    double cpu_time_used;
    char *array;
    clock_gettime(CLOCK_REALTIME, &start);
    array = (char *)calloc(length, sizeof(char));
    if (array == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    clock_gettime(CLOCK_REALTIME, &stop);
    cpu_time_used = (stop.tv_sec - start.tv_sec) + (double)(stop.tv_nsec - start.tv_nsec) / (double)BILLION;

    for (size_t i = 1; i < length; i++)
    {
        array[i]++;
        if (i % 1000000000 == 0)
        {
            printf("array[%zu] = %c\n", i, array[i]);
        }
    }
    free(array);

    return cpu_time_used;
}

int main(int argc, char *argv[])
{
    if (argc != 5)
    {
        fprintf(stderr, "Usage: %s <length> <initial_value> <iterations> <csv_file>\n", argv[0]);
        return 1;
    }

    size_t length = strtoull(argv[1], NULL, 10);
    char initial_value = argv[2][0];
    size_t iterations = strtoull(argv[3], NULL, 10);
    const char *csv_filename = argv[4];

    FILE *csv_file = fopen(csv_filename, "a");
    if (csv_file == NULL)
    {
        fprintf(stderr, "Could not open file for writing\n");
        return 1;
    }

    // Check if the file is empty to write the header
    fseek(csv_file, 0, SEEK_END);
    long file_size = ftell(csv_file);
    if (file_size == 0)
    {
        fprintf(csv_file, "Language,Operation,Iteration,Time,Length\n");
    }

    for (size_t i = 0; i < iterations; i++)
    {
        double time_alloc_init = time_allocation_and_initialization(length, initial_value);
        fprintf(csv_file, "C,Alloc_set,%zu,%f,%zu\n", i + 1, time_alloc_init, length);

        double time_alloc = time_allocation(length);
        fprintf(csv_file, "C,Alloc,%zu,%f,%zu\n", i + 1, time_alloc, length);

        double time_calloc_init = time_callocation_and_initialization(length, initial_value);
        fprintf(csv_file, "C,Calloc_set,%zu,%f,%zu\n", i + 1, time_calloc_init, length);

        double time_calloc = time_callocation(length);
        fprintf(csv_file, "C,Calloc_zero,%zu,%f,%zu\n", i + 1, time_calloc, length);

        double time_alloc_init_loop = time_allocation_and_initialization_loop(length, initial_value);
        fprintf(csv_file, "C,Alloc_set_loop,%zu,%f,%zu\n", i + 1, time_alloc_init_loop, length);

        double time_calloc_init_loop = time_callocation_and_initialization_loop(length, initial_value);
        fprintf(csv_file, "C,Calloc_set_loop,%zu,%f,%zu\n", i + 1, time_calloc_init_loop, length);

        double time_alloc_init_openmp_simd = time_allocation_and_initialization_openmp_simd(length, initial_value);
        fprintf(csv_file, "C,Alloc_set_openmp_simd,%zu,%f,%zu\n", i + 1, time_alloc_init_openmp_simd, length);

        double time_calloc_init_openmp_simd = time_callocation_and_initialization_openmp_simd(length, initial_value);
        fprintf(csv_file, "C,Calloc_set_openmp_simd,%zu,%f,%zu\n", i + 1, time_calloc_init_openmp_simd, length);
    }

    fclose(csv_file);

    return 0;
}

/*
Compilation command:
gcc -O2 -fopenmp -o time_array_allocation time_array_allocation.c -std=c99

Example invocation:
./time_array_allocation 10000000 A 10 benchmark_results.csv
*/
