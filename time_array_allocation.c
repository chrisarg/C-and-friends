#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

char* allocate_and_initialize_array(size_t length, char initial_value) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset(array, initial_value, length);

    return array;
}

double time_allocation_and_initialization(size_t length, char initial_value) {
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    char* array = allocate_and_initialize_array(length, initial_value);
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    /* This rudimentary loop prevents the compiler from optimizing out the 
     * allocation/initialization with the de-allocation
    */
    for(size_t i = 1; i < length; i++) {
       array[i]++;
       if(i % 100000 == 0) {
           printf("array[%zu] = %c\n", i, array[i]);
       }
    }
    free(array); // Free the allocated memory

    return cpu_time_used;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <length> <initial_value>\n", argv[0]);
        return 1;
    }

    size_t length = strtoull(argv[1], NULL, 10);
    char initial_value = argv[2][0];

    double time_taken = time_allocation_and_initialization(length, initial_value);
    printf("Time taken to allocate and initialize array: %f seconds\n", time_taken);
    printf("Initializes per second: %f\n", 1/time_taken);

    return 0;
}

/*
Compilation command:
gcc -O2 -o time_array_allocation time_array_allocation.c -std=c99

Example invocation:
./time_array_allocation 10000000 A
*/
