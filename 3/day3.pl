#!/usr/bin/perl
#title           :day5.pl
#description     :
#author          :mgriessmeier
#version         :who needs version when we have git?
#usage           :common, obvious, isn't it?
#==============================================================================

use strict;
use warnings;
use Test::More;
use Data::Dumper qw(Dumper);

sub visited_once {
    my $input = shift(@_);     
    my $x = 0;
    my $y = 0;
    my @matrix = split //, $input;
    my $visited_houses={};
    
    $visited_houses->{$x}{$y} = 1;

    foreach my $step (@matrix) {
        if ($step eq '^') { $y += 1; } 
        elsif ($step eq '>') { $x += 1; } 
        elsif ($step eq 'v') { $y -= 1; } 
        elsif ($step eq '<') { $x -= 1; }
    
        $visited_houses->{$x}{$y} += 1;
    }
    my $count = 0;
    foreach my $i (keys %$visited_houses) {
        foreach my $j (keys %{$visited_houses->{$i}}) {
            print $j . "\n"  ;
            $count += 1;
        }
    }
    return $count;
}

# For example:
#
# > delivers presents to 2 houses: one at the starting location, and one to the east.
is(visited_once(">"), 2, "example1");

# ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
is(visited_once("^>v<"), 4, "example2");

# ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
is(visited_once("^v^v^v^v^v"), 2, "example3");

done_testing();

open(FILE, "day3.txt");
chomp(my @matrix = <FILE>);
close FILE;
print ("Part 1: " . visited_once(@matrix) . "\n");


