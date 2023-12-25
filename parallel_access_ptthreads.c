// passing multidimensional arrays to functions

#include <stdio.h>
#include <pthread.h>
#include <stdatomic.h>
#include <math.h>
#include <tgmath.h>

#define COUNT 1000000L
#define USEDDOUBLE
#ifdef USEDDOUBLE
    #define TYPE_ARG long double
    #define FMT "Lf"
    #define MOD(x,y) fmodl((x),(y))
#else
    #define TYPE_ARG long 
    #define FMT "ld"
    #define MOD(x,y) (x) % (y)
#endif
#define thrd_success 0
TYPE_ARG counter1 = 0L;
TYPE_ARG counter2 = 0L;

void incCounter() {
    printf("Increase entry\n");
    for(long i=0; i < COUNT; i++) {
        counter1+=sin(i);
        if (MOD(i,10000) == 0)
            printf("\tcounter1 = %" FMT "\n", counter1);
    }

    printf("Increase exit\n");
}   
void decCounter() {
    printf("Decrease entry\n");
    for(long i=0; i < COUNT; i++){
        counter2-=sin(i);
        if (MOD(i,10000) == 0)
            printf("\t\tcounter2 = %" FMT "\n", counter2);
    }
    printf("Decrease exit\n");
}



int main() {
    pthread_t t1, t2;
    printf("Let the fun begin ""\n");
    clock_t start = clock();
    if(pthread_create(&t1, NULL, incCounter, NULL) != thrd_success
        || pthread_create(&t2, NULL, decCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }
    
    pthread_join(t1,NULL);
    printf("in between\n");
    pthread_join(t2,NULL);
    //atomic_thread_fence(memory_order_release);
    printf("counter1 = %" FMT ",\t counter2 = %" FMT "\n", counter1,counter2);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);

    //alternative way to create threads
    printf("\n\n Alternative way to create threads\n\n");
    start = clock();
    if(pthread_create(&t1, NULL, incCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }
    pthread_join(t1,NULL);
     if(pthread_create(&t2, NULL, decCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }   
    printf("in between\n");
    pthread_join(t2,NULL);
    //atomic_thread_fence(memory_order_release);
    printf("counter1 = %" FMT ",\t counter2 = %" FMT "\n", counter1,counter2);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);

    printf("\n\n Serial execution\n\n");
    start = clock();
    incCounter();
    printf("in between\n");
    decCounter();
    printf("counter1 = %" FMT ",\t counter2 = %" FMT "\n", counter1,counter2);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);
    return 0;
}