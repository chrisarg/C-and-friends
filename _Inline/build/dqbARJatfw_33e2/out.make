Running Mkbootstrap for dqbARJatfw_33e2 ()
chmod 644 "dqbARJatfw_33e2.bs"
"/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- dqbARJatfw_33e2.bs blib/arch/auto/dqbARJatfw_33e2/dqbARJatfw_33e2.bs 644
"/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/bin/perl" "/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/ExtUtils/xsubpp"  -typemap "/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/ExtUtils/typemap"   dqbARJatfw_33e2.xs > dqbARJatfw_33e2.xsc
mv dqbARJatfw_33e2.xsc dqbARJatfw_33e2.c
g++ -c  -iquote"/tmp"  -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -march=native -O2   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/home/chrisarg/perl5/perlbrew/perls/perl-5.38.0/lib/5.38.0/x86_64-linux/CORE"   dqbARJatfw_33e2.c
make: *** Deleting file 'dqbARJatfw_33e2.o'
make: *** [Makefile:344: dqbARJatfw_33e2.o] Interrupt
