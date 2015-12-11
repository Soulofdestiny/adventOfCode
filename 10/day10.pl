#!/usr/bin/perl
#title           :day10.pl
#description     :
#author          :mgriessmeier
#version         :who needs version when we have git?
#usage           :common, obvious, isn't it?
#==============================================================================

use strict;
use warnings;
use Test::More;
use Data::Dumper qw(Dumper);


sub sequence_test {
    my $input = shift(@_);
    $input =~ s/(.)\1*/length($&).$1/eg;
    return $input;
}

sub sequence {
    my ($sequence, $iterations) = @_;

    for (my $i = 0; $i < $iterations; $i++) {
        $sequence =~ s/(.)\1*/length($&).$1/eg; 
    }

    return $sequence;
}

sub len_sequence {
    my $sequence = sequence_test(shift(@_));
    return length($sequence);
}

### PART 1 ###
# 1 becomes 11 (1 copy of digit 1).
is(sequence_test("1"), 11, "example1");
is(len_sequence("1"), 2, "example1");

# 11 becomes 21 (2 copies of digit 1).
is(sequence_test("11"), 21, "example2");
is(len_sequence("11"), 2, "example2");

# 21 becomes 1211 (one 2 followed by one 1).
is(sequence_test("21"), 1211, "example3");
is(len_sequence("21"), 4, "example3");

# 1211 becomes 111221 (one 1, one 2, and two 1s).
is(sequence_test("1211"), 111221, "example4");
is(len_sequence("1211"), 6, "example4");

# 111221 becomes 312211 (three 1s, two 2s, and one 1).
is(sequence_test("111221"), 312211, "example5");
is(len_sequence("111221"), 6, "example5");


### PART 2 ###

done_testing();

my $input = "1113122113";
print ("Part 1: length of sequence with 40 iterations: " . length(sequence($input, 40)) . "\n");
print ("Part 2: length of sequence with 50 iterations: " . length(sequence($input, 50)) . "\n");


