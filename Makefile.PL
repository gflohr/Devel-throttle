#! /usr/local/bin/perl # -*- perl -*-

# This file is part of Devel-throttle.
# Copyright (C) 2009 Guido Flohr <guido@imperia.net>, 
# all rights reserved.

# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

use 5.004;
use ExtUtils::MakeMaker;

WriteMakefile (
    NAME		    => 'Devel::throttle',
    VERSION_FROM	    => 'lib/Devel/throttle.pm',
    ($] >= 5.005 ?
		(ABSTRACT	=> 'Slow down Perl scripts.',
	 	 AUTHOR		=> 'Guido Flohr <guido@imperia.net>',
    ) : (),
    ),
    PL_FILES => {},
    (MM->can ('signature_target') ? (SIGN => 1) : ()),
    LICENSE => 'Artistic',
);

sub MY::postamble {
   	q ( 
all :: ReleaseNotes

# Make search.cpan.org happy but still follow GNU standards:
# (Thanks to Graham Barr for the hint)
ReleaseNotes: NEWS
	cat NEWS >$@
	);
}

__END__

Local Variables:
mode: perl
perl-indent-level: 4
perl-continued-statement-offset: 4
perl-continued-brace-offset: 0
perl-brace-offset: -4
perl-brace-imaginary-offset: 0
perl-label-offset: -4
cperl-indent-level: 4
cperl-continued-statement-offset: 2
tab-width: 8
End:
