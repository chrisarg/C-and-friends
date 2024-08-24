#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
## check newxz allocation
use v5.38;
use Inline (
    C         => 'DATA',
    cc        => 'g++',
    ld        => 'g++',
    inc       => q{},                # replace q{} with anything else you need
    ccflagsex => q{-march=native},
    lddlflags => join(
        q{ },
        $Config::Config{lddlflags},
        q{ },                        # replace q{ } with anything else you need
    ),
    libs => join(
        q{ },
        $Config::Config{libs},
        q{ },                        # replace q{ } with anything else you need
    ),
    myextlib => ''
);


use Convert::Scalar qw(grow);
my $sleep =10;
my $length = 10_000_000_000;
my $addr = alloc_with_Newx_touch($length,65);
say $addr;

sleep $sleep;

my $addr2 = alloc_with_Newx_touch($length,66);

say $addr2;

sleep $sleep;


my $addr3 = alloc_with_malloc($length);

say $addr3;

sleep $sleep;

my $addr4 = alloc_with_malloc_touch($length,66);

say $addr4;

sleep $sleep;

## print the differences among the 4 values of the $addr variables
say "Differences between the 4 values of the addr variables";
say "addr2 - addr2 ", $addr2-$addr;
say "addr3 - addr  ", $addr3-$addr;
say "addr4 - addr1 ", $addr4-$addr;
say "addr3 - addr2 ", $addr3-$addr2;
say "addr4 - addr2 ", $addr4-$addr2;
say "addr4 - addr3 ", $addr4-$addr3;


__DATA__

__C__

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <immintrin.h>
#include <stddef.h>

SV* alloc_with_Newx_touch(size_t length,short initial_value) {
    char* array ;
    Newx(array, length, char);
    array[length-1] = (char)initial_value;
    return newSVuv(PTR2UV(array));
}

SV* _print_array(size_t mem_addr ,size_t length) {
    char* array = (char*)mem_addr;

    for (size_t i = 0; i < length; i++) {
        printf("%02x ", (unsigned char)array[i]);
        if ((i + 1) % 10 == 0) {
            printf("\n");
        }
    }
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_malloc(size_t length) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    return newSVuv(PTR2UV(array));
}

SV* alloc_with_malloc_touch(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    /*
    * Touch every 4K
        size_t touch_length = length / (4*1024);
        for (size_t i = 0; i < length; i += touch_length) {
            array[i] = (char)initial_value;
        }
    */ 
    array[length-1] = (char)initial_value;
    return newSVuv(PTR2UV(array));
}