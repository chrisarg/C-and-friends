#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
## this is a stump script that uses glibc to set memory
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

use Time::HiRes     qw(time);
use Convert::Scalar qw(grow);
use Getopt::Long;
use Text::CSV;

my ( $buffer_size, $init_value, $iterations, $csv_file ) = (
    'BUFFER_SIZE',
    'INIT_VALUE',
    'ITERATIONS',
    'CSV_FILE'
);

my $init_value_byte = ord($init_value);
my %code_snippets  = (
    OPERATION => {
        language => 'LANGUAGE',
        function => sub {'CODE'},
    },
);


my $file_exists = -e $csv_file;
my $csv         = Text::CSV->new( { binary => 1, eol => $/ } );
open my $fh, ">>", $csv_file or die "Could not open '$csv_file' $!\n";

# Write header if the file is newly created
unless ($file_exists) {
    $csv->print( $fh,
        [ "Language", "Operation", "Iteration", "Time", "Length" ] );
}

sub benchmark_code {
    my ( $code_ref, $operation ) = @_;
    my $start_time = time();
    $code_ref->();
    my $end_time     = time();
    my $elapsed_time = $end_time - $start_time;
    return $elapsed_time;
}

while ( my ( $operation, $property ) = each %code_snippets ) {
    for my $i ( 1 .. $iterations ) {
        my $elapsed_time = benchmark_code( $property->{function}, $operation );
        $csv->print(
            $fh,
            [
                $property->{language}, $operation, $i,
                $elapsed_time,         $buffer_size
            ]
        );
    }
}

close $fh;


__DATA__

__C__

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

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
    // touch every 4K 
    size_t touch_length = length / (4*1024);
    for (size_t i = 0; i < length; i += touch_length) {
        array[i] = (char)initial_value;
    }
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_malloc_and_set(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_calloc(size_t length) {
    // Allocate memory for the array
    char* array = (char *)calloc(length ,sizeof(char));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_calloc_touch(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char *)calloc(length ,sizeof(char));
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
    array[0] = (char)initial_value;
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_calloc_and_set(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char *)calloc(length ,sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newx(size_t length) {
    char* array ;
    Newx(array, length, char);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newxz(size_t length) {
    char* array ;
    Newxz(array, length, char);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newx_touch(size_t length,short initial_value) {
    char* array ;
    Newx(array, length, char);
    array[0] = (char)initial_value;
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newxz_touch(size_t length,short initial_value) {
    char* array ;
    Newxz(array, length, char);
    array[0] = (char)initial_value;
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newx_and_set(size_t length, short initial_value) {
    char* array ;
    Newx(array, length, char);
    char initial_value_byte = (char)initial_value;
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newxz_and_set(size_t length, short initial_value) {
    char* array ;
    Newxz(array, length, char);
    char initial_value_byte = (char)initial_value;
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}
