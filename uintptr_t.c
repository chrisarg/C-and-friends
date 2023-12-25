#include <stdio.h>
#include <stdint.h>

int main() {
    long long int a = -12345678;
    unsigned long long int b = 12345678;
    double d = 123.25E+3;
    uintptr_t ud = (uintptr_t) &d;
    uintptr_t ua = (uintptr_t) &a;
    uintptr_t ub = (uintptr_t) &b;
    intptr_t * uda = (intptr_t *)&b;
    printf("a = %lld, b = %llu, d = %f\n", a, b, d);
    printf("ua = %lu, ub = %lu, ud = %lu\n", ua, ub, ud);
    printf("*uda = %ld, uda=%lu\n", *uda,(intptr_t) uda);
    return 0;
}