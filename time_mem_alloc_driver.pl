#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
## this is a driver script that will test work flows of serial allocations
## using various approaches from within Perl and C
use v5.38;
use Getopt::Long;
use File::Temp qw(tempfile);
use File::Spec;
use FindBin qw($Bin);
my ( $buffer_size, $init_value, $iterations, $csv_file, $stump_fname );

GetOptions(
    'buffer_size=i' => \$buffer_size,
    'init_value=s'  => \$init_value,
    'iterations=i'  => \$iterations,
    'csv_file=s'    => \$csv_file,
    'stump_fname=s' => \$stump_fname,
  )
  or die
"Usage: $0 --stump_fname <stump file> --buffer_size <size> --init_value <value> --iterations <count> --csv_file <file>\n";
my $init_value_byte = ord($init_value);

my %code_snippets = (
    'pack_dot_zero' => {
        language => 'Perl',
        function => q{
           my $str =  pack( ".", $buffer_size );
        }
    },
    'pack_x_zero' => {
        language => 'Perl',
        function => q{
            my $str = pack("x$buffer_size");
        }
    },
    'Newx' => {
        language => 'PerlAPI',
        function => q{
            my $str = alloc_with_Newx($buffer_size);
        }
    },
    'Newxz_zero' => {
        language => 'PerlAPI',
        function => q{
            my $str = alloc_with_Newxz($buffer_size);
        }
    },
    'C_malloc' => {
        language => 'C',
        function => q{
            my $str = alloc_with_malloc($buffer_size);
        }
    },
    'C_calloc_zero' => {
        language => 'C',
        function => q{
            my $str = alloc_with_calloc($buffer_size);
        }
    },
    'string_set' => {
        language => 'Perl',
        function => q{
            my $str = $init_value x ( $buffer_size - 1 );
        }
    },
    'pack_set' => {
        language => 'Perl',
        function => q{
            my $str = pack "C*", ( ($init_value_byte) x $buffer_size );
        }
    },
    'vec_set' => {
        language => 'Perl',
        function => q{
            my $z = '';
            vec( $z, $buffer_size - 1, 8 ) = $init_value_byte;
            $z = '';
        }
    },
    'Newx_set' => {
        language => 'PerlAPI',
        function => q{
            my $str = alloc_with_Newx_and_set( $buffer_size, $init_value_byte );
        }
    },
    'Newxz_set' => {
        language => 'PerlAPI',
        function => q{
            my $str =
              alloc_with_Newxz_and_set( $buffer_size, $init_value_byte );
        }
    },
    'C_malloc_and_set' => {
        language => 'C',
        function => q{
            my $str =
              alloc_with_malloc_and_set( $buffer_size, $init_value_byte );
        }
    },
    'C_calloc_and_set' => {
        language => 'C',
        function => q{
            my $str =
              alloc_with_calloc_and_set( $buffer_size, $init_value_byte );
        }
    },
);

while ( my ( $name, $snippet ) = each %code_snippets ) {
    my $language = $snippet->{language};
    my $function = $snippet->{function};

    #Read the original script into a string
    my $original_file = File::Spec->catfile( $Bin, 'time_mem_alloc_stump.pl' );
    my $csv_file      = File::Spec->catfile( $Bin, $csv_file );
    open my $fh, '<', $original_file
      or die "Could not open '$original_file': $!";
    my $script_content = do { local $/; <$fh> };
    close $fh;

    # Modify the string to replace the desired values
    $script_content =~ s/'BUFFER_SIZE'/$buffer_size/s;
    $script_content =~ s/INIT_VALUE/$init_value/s;
    $script_content =~ s/'ITERATIONS'/$iterations/s;
    $script_content =~ s/CSV_FILE/$csv_file/s;
    $script_content =~ s/LANGUAGE/$language/s;
    $script_content =~ s/'CODE'/$function/s;
    $script_content =~ s/OPERATION/$name/s;

    #
    # Write the modified string to a temporary file
    my ( $temp_fh, $temp_filename ) = tempfile();
    print $temp_fh $script_content;
    close $temp_fh;

    # Make the temporary file executable
    chmod 0755, $temp_filename;

    # Execute the temporary file
    system($temp_filename);

    # Clean up the temporary file
    unlink $temp_filename;
}
