use ExtUtils::MakeMaker;
my %options = %{
{
  'NAME' => 'BYn1V3Lewf_33e2',
  'CCFLAGS' => ' -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -march=native',
  'CC' => 'g++',
  'LDDLFLAGS' => ' -shared -O2 -L/usr/local/lib -fstack-protector-strong  ',
  'TYPEMAPS' => [
    '/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/ExtUtils/typemap'
  ],
  'LD' => 'g++',
  'INC' => '-iquote"/tmp" ',
  'LIBS' => [
    '-lpthread -ldb -ldl -lm -lcrypt -lutil -lc  '
  ],
  'MYEXTLIB' => ' ',
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
