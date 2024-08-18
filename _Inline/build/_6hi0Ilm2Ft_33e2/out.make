Running Mkbootstrap for _6hi0Ilm2Ft_33e2 ()
chmod 644 "_6hi0Ilm2Ft_33e2.bs"
"/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- _6hi0Ilm2Ft_33e2.bs blib/arch/auto/_6hi0Ilm2Ft_33e2/_6hi0Ilm2Ft_33e2.bs 644
"/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/bin/perl" "/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/ExtUtils/xsubpp"  -typemap "/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/ExtUtils/typemap"   _6hi0Ilm2Ft_33e2.xs > _6hi0Ilm2Ft_33e2.xsc
mv _6hi0Ilm2Ft_33e2.xsc _6hi0Ilm2Ft_33e2.c
g++ -c  -iquote"/tmp"  -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -march=native -O2   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/x86_64-linux/CORE"   _6hi0Ilm2Ft_33e2.c
make: *** Deleting file '_6hi0Ilm2Ft_33e2.o'
make: *** [Makefile:344: _6hi0Ilm2Ft_33e2.o] Interrupt
