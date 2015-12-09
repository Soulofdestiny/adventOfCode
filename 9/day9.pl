#!/usr/bin/perl
#title           :day9.pl
#description     :
#author          :mgriessmeier
#version         :who needs version when we have git?
#usage           :common, obvious, isn't it?
#==============================================================================

use strict;
use warnings;
use Test::More;
use Data::Dumper qw(Dumper);
use List::Util qw(min max);
use List::MoreUtils qw(uniq);
use Math::Combinatorics qw/permute/;
use Log::Message::Simple qw[msg error debug carp croak cluck confess];

my $VERBOSE = 1;


sub sum_of_path {
    # TODO $num_locations should be replaced by number of destinations on each path
    my ($path, $idx_last_loc, %hash) = @_;
    my $sum_of_path = 0;
    for (my $i = 0; $i <$idx_last_loc; $i++) { 
        my $subpath = $hash{$path->[$i] . ' to ' . $path->[$i+1]} || $hash{$path->[$i+1] . ' to ' . $path->[$i]};
        $sum_of_path += $subpath;
    }
    return $sum_of_path;
}


sub find_min_max {
    my @input = @_;
    my %hash = map { my ( $key, $value ) = split " = "; $key => int($value) } @input;
    my @locations = uniq map { split " to "} keys \%hash;
    my @paths = permute(@locations);
    my %paths = map { my ($key, $value ) = ($_, sum_of_path($_, $#locations, %hash)); $key => $value } @paths;
    # find minimum of all values in %paths
    my $min = min values \%paths;
    my $max = max values \%paths;
    # optional: return key of this value
    msg("min: " . $min . ", max: " . $max, $VERBOSE);

    return $min, $max;
}

sub find_shortest {
    my ($min, $max) = find_min_max(@_);
    return $min;
}

sub find_longest {
    my ($min, $max) = find_min_max(@_);
    return $max;
}

# For example, given the following distances:
open(FILE, "day9-example.txt");
chomp(my @example = <FILE>);
close FILE;
is(find_shortest(@example), '605', "example-1");
is(find_longest(@example), '982', "example-1");
done_testing();

open(FILE, "day9.txt");
chomp(my @input = <FILE>);
close FILE;

print ("Part 1: " . find_shortest(@input) . "\n");
print ("Part 2: " . find_longest(@input) . "\n");
