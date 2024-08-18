#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
## this script creates unfortunately dependency between the different allocators
## it is used only to scrap code for the other scripts
use v5.38;
use Inline (
    C         => 'DATA',
    cc        => 'g++',
    ld        => 'g++',
    inc       => q{},      # replace q{} with anything else you need
    ccflagsex => q{-march=native},      
    lddlflags => join(
        q{ },
        $Config::Config{lddlflags},
        q{ },              # replace q{ } with anything else you need
    ),
    libs => join(
        q{ },
        $Config::Config{libs},
        q{ },              # replace q{ } with anything else you need
    ),
    myextlib => ''
);

use Time::HiRes     qw(time);
use Convert::Scalar qw(grow);
use Getopt::Long;
use Text::CSV;

my ( $buffer_size, $init_value, $iterations, $csv_file );
GetOptions(
    'buffer_size=i' => \$buffer_size,
    'init_value=s'  => \$init_value,
    'iterations=i'  => \$iterations,
    'csv_file=s'    => \$csv_file,
  )
  or die
"Usage: $0 --buffer_size <size> --init_value <value> --iterations <count> --csv_file <file>\n";
my $init_value_byte = ord($init_value);

my %code_snippets = (
    'pack_dot_zero' => {
        language => 'Perl',
        function => sub {
            pack( ".", $buffer_size );
        }
    },
    'pack_x_zero' => {
        language => 'Perl',
        function => sub {
            pack("x$buffer_size");
        }
    },
    'Newx' => {
        language => 'PerlAPI',
        function => sub {
            my $str = alloc_with_Newx($buffer_size);
        }
    },
    'Newxz_zero' => {
        language => 'PerlAPI',
        function => sub {
            my $str = alloc_with_Newxz($buffer_size);
        }
    },
    'C_malloc' => {
        language => 'C',
        function => sub {
            alloc_with_malloc($buffer_size);
        }
    },
    'C_calloc_zero' => {
        language => 'C',
        function => sub {
            alloc_with_calloc($buffer_size);
        }
    },
    'string_set' => {
        language => 'Perl',
        function => sub {
            my $str = $init_value x ( $buffer_size - 1 );
        }
    },
    'pack_set' => {
        language => 'Perl',
        function => sub {
            my $str = pack "C*", ( ($init_value_byte) x $buffer_size );
        }
    },
    'vec_set' => {
        language => 'Perl',
        function => sub {
            my $z = '';
            vec( $z, $buffer_size - 1, 8 ) = $init_value_byte;
            $z = '';
        }
    },
    'Newx_set' => {
        language => 'PerlAPI',
        function => sub {
            my $str = alloc_with_Newx_and_set( $buffer_size, $init_value_byte );
        }
    },
    'Newxz_set' => {
        language => 'PerlAPI',
        function => sub {
            my $str =
              alloc_with_Newxz_and_set( $buffer_size, $init_value_byte );
        }
    },
    'C_malloc_and_set' => {
        language => 'C',
        function => sub {
            my $str =
              alloc_with_malloc_and_set( $buffer_size, $init_value_byte );
        }
    },
    'C_calloc_and_set' => {
        language => 'C',
        function => sub {
            my $str =
              alloc_with_calloc_and_set( $buffer_size, $init_value_byte );
        }
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

=begin comment

This is a coderef for the grow subroutine which has amazing performance for 
unclear reasons

'grow' => sub {
    my $str;
    grow $str, $buffer_size;
},
=end comment

=cut

__DATA__

__C__

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <immintrin.h>
#include <stddef.h>

void *memset_avx2(void *s, int c, size_t n) {
    unsigned char *p = (unsigned char *)s;
    __m256i value = _mm256_set1_epi8((unsigned char)c);

    size_t i;
    for (i = 0; i + 31 < n; i += 32) {
        _mm256_storeu_si256((__m256i *)(p + i), value);
    }

    for (; i < n; i++) {
        p[i] = (unsigned char)c;
    }

    return s;
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

SV* alloc_with_malloc_and_set(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset_avx2(array, initial_value_byte, length);
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

SV* alloc_with_calloc_and_set(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char *)calloc(length ,sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset_avx2(array, initial_value_byte, length);
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

SV* alloc_with_Newx_and_set(size_t length, short initial_value) {
    char* array ;
    Newx(array, length, char);
    char initial_value_byte = (char)initial_value;
    memset_avx2(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newxz_and_set(size_t length, short initial_value) {
    char* array ;
    Newxz(array, length, char);
    char initial_value_byte = (char)initial_value;
    memset_avx2(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}
