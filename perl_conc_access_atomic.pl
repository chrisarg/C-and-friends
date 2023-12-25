#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
use v5.38;
###############################################################################
## dependencies
use Inline C => 'DATA';    # various C functions

test_atomic();

__DATA__
__C__
#include <stdio.h>
#include <threads.h>
#include <stdatomic.h>

#define COUNT 10000000L
_Atomic long counter = ATOMIC_VAR_INIT(0L);
void incCounter() {
    for(long i=0; i < COUNT; i++)
        counter++;
}   
void decCounter() {
    for(long i=0; i < COUNT; i++)
        counter--;
}

void incCounter_memorder() {
    for(long i=0; i < COUNT; i++)
        atomic_fetch_add_explicit(&counter, 1, memory_order_relaxed);
}   
void decCounter_memorder() {
    for(long i=0; i < COUNT; i++)
        atomic_fetch_sub_explicit(&counter, 1, memory_order_relaxed);
}

void test_atomic() {
    thrd_t t1, t2;
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

    // atomic fetch
    start = clock();
    if(thrd_create(&t1, (thrd_start_t)incCounter_memorder, NULL) != thrd_success
        || thrd_create(&t2, (thrd_start_t)decCounter_memorder, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }
    thrd_join(t1, NULL);
    thrd_join(t2, NULL);
    printf("counter = %ld\n", counter);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);
    return 0;
}