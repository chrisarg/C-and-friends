// passing multidimensional arrays to functions

#include <stdio.h>
#include <threads.h>

#define COUNT 1000000L
long counter = 0;
mtx_t mutex;
void incCounter() {
    for(long i=0; i < COUNT; i++){
        mtx_lock(&mutex);
        counter++;
        mtx_unlock(&mutex);
    }
}   
void decCounter() {
    for(long i=0; i < COUNT; i++)
    {
        mtx_lock(&mutex);
        counter--;
        mtx_unlock(&mutex);
    }
}

int main() {
    thrd_t t1, t2;
    if(mtx_init(&mutex, mtx_plain) != thrd_success) {
        printf("Error creating mutex.\n");
        return -1;
    }
    clock_t start = clock();
    if(thrd_create(&t1, (thrd_start_t)incCounter, NULL) != thrd_success
        || thrd_create(&t2, (thrd_start_t)decCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }
    
    thrd_join(t1, NULL);
    thrd_join(t2, NULL);
    printf("counter = %ld\n", counter);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);
    mtx_destroy(&mutex);
    return 0;
}