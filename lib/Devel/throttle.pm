#! /bin/false

# This file is part of Devel-throttle.
# Copyright (C) 2009 Guido Flohr <guido@imperia.net>, 
# all rights reserved.

# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

package Devel::throttle;

use strict;

use vars qw ($VERSION @args);
$VERSION = '0.01';

sub import {
	my ($self, $throttle, @code) = @_;

	$DB::throttle = $throttle;

	if (@code) {
		my $code = shift @code;

		if (ref $code && 'CODE' eq ref $code) {
			$DB::throttlefunc = $code;
		}

		if (ref $code && 'CODE' eq ref $code) {
			@args = @code;
		} else {
			@args = ();
			$DB::throttlefunc = sub { eval $code; warn $@ if $@ };
		}
	} else {
		@args = ();
	}
}

sub throttlefunc {
	my $timeout = shift || 0;

	$timeout *= 1;

	return unless $timeout > 0;

	select undef, undef, undef, $timeout
		if $timeout;
}

package DB;

$DB::throttlefunc = \&Devel::throttle::throttlefunc;

sub DB {
	my @args = @Devel::throttle::args ?
		@Devel::throttle::args : $DB::throttle; 

	$DB::throttlefunc->(@args)
		if $DB::throttlefunc;
}

1;
