#! /bin/false

# This file is part of Devel-throttle.
# Copyright (C) 2009 Guido Flohr <guido@imperia.net>, 
# all rights reserved.

# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

package Devel::throttle;

use vars qw ($VERSION $throtte);
$VERSION = '0.01';
$throttle = 0;

sub import {
	my ($self, $sec) = @_;

	$throttle = $sec;
}

package DB;

sub DB {
	if ($Devel::throttle::throttle) {
		my $throttle = 1 * $Devel::throttle::throttle;
	
		select undef, undef, undef, $throttle
			if $throttle > 0;
	}
}

1;
