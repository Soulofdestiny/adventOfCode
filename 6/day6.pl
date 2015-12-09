#!/usr/bin/perl
#title           :day6.pl
#description     :
#author          :mgriessmeier
#version         :who needs version when we have git?
#usage           :common, obvious, isn't it?
#==============================================================================

use strict;
use warnings;
use Test::More;
use Data::Dumper qw(Dumper);

open(FILE, "day6.txt");
chomp(my $input = <FILE>);
close FILE;


sub lights_lit {
    my $input = shift(@_);
    my $count = 0;
    return $count;
}


#turn on 0,0 through 999,999 would turn on (or leave on) every light.
is(lights_lit($input, '0,0 through 999,999' ), "example-1");

#toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
ok(lights_lit($input, '0,0 through 999,0' ), "example-2");

#turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
ok(lights_lit($input, '499,499 through 500,500' ), "example-3");

done_testing();

print ("Part 1: "  . "\n");


