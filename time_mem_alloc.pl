#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
use v5.38;
use Inline C => 'DATA';
use Benchmark qw(cmpthese);
my $init_value      = 'A';
my $init_value_byte = ord($init_value);
my $buffer_size     = 100_000_000;
my $iterations      = 100;
my %code_snippets   = (
    'string' => sub {
        $init_value x ( $buffer_size - 1 );
    },
    'pack' => sub {
        pack "C*", ( ($init_value_byte) x $buffer_size );
    },
    'C' => sub {
        allocate_and_initialize_array( $buffer_size, $init_value_byte );
    },
);

cmpthese( $iterations, \%code_snippets );

__DATA__

__C__

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

SV* allocate_and_initialize_array(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset(array, initial_value_byte, length);
    return newSVuv(array);
}
