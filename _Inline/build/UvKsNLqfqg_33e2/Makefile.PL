use ExtUtils::MakeMaker;
my %options = %{
{
  'TYPEMAPS' => [
    '/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/ExtUtils/typemap'
  ],
  'NAME' => 'UvKsNLqfqg_33e2',
  'LDDLFLAGS' => ' -shared -O2 -L/usr/local/lib -fstack-protector-strong  ',
  'MYEXTLIB' => ' ',
  'CC' => 'g++',
  'LIBS' => [
    '-lpthread -ldb -ldl -lm -lcrypt -lutil -lc  '
  ],
  'CCFLAGS' => ' -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -march=native',
  'LD' => 'g++',
  'INC' => '-iquote"/tmp" ',
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
