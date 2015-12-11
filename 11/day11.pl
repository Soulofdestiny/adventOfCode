#!/usr/bin/perl
#title           :day11.pl
#description     :
#author          :mgriessmeier
#version         :who needs version when we have git?
#usage           :common, obvious, isn't it?
#==============================================================================

use strict;
use warnings;
use Test::More;
use Data::Dumper qw(Dumper);


sub contains_straight {
    my @chars = split("", shift(@_));
    my $valid = 0;
    for (my $c = 0; $c < $#chars-1; $c++) {
        my $test_char = $chars[$c];
        my $next_char = ++$test_char;
        my $next_next_char = ++$test_char;
        if (($next_char eq $chars[$c+1]) && ($next_next_char eq $chars[$c+2])) {
            $valid = 1;
            last;
        }
    }
    return $valid;
}

sub does_not_contain_ambiguous {
    return shift(@_) =~ /[iol]/ ? 0 : 1;
}

sub contains_different_pairs {
    my $input = shift(@_);
    #return unless $input =~ /((.)\1)(?!\1\1)
    # search for a pair
    my $valid = 0;
    # foreach pair
    my @pair_char = $input =~ /(.)\1/g;
    foreach (@pair_char) {
    #  if pair != first_pair return valid
        return 1 if $_ !~ /$pair_char[0]/;
    }
    return 0;
}

sub is_invalid {
    my $input = shift(@_);
    
    return 1 unless contains_straight($input);
    return 1 unless does_not_contain_ambiguous($input);
    return 1 unless contains_different_pairs($input);
    return 0;
}


sub find_valid {
    my $input = shift(@_);
    while (is_invalid($input)) {
        $input++;
    }
    return $input;
}

sub find_next_valid {
    my $input = shift(@_);
    ++$input;
    return find_valid($input);
}

### PART 1 ###
# hijklmmn meets the first requirement (because it contains the straight hij) but fails the second requirement requirement (because it contains i and l).
my $in = "hijklmmn";
ok(contains_straight($in), "ex1"); 
ok(!does_not_contain_ambiguous($in), "ex1"); 
ok(is_invalid($in), "ex1"); 

# abbceffg meets the third requirement (because it repeats bb and ff) but fails the first requirement.
my $in2 = "abbceffg";
ok(contains_different_pairs($in2), "ex2");
ok(!contains_straight($in2), "ex2");
ok(is_invalid($in2), "ex2"); 

# abbcegjk fails the third requirement, because it only has one double letter (bb).
my $in3 = "abbcegjk";
ok(!contains_different_pairs($in3), "ex3");
ok(is_invalid($in3), "ex3"); 

# The next password after abcdefgh is abcdffaa.
ok(!is_invalid("abcdffaa"), "ex4");
is(find_valid("abcdefgh"), "abcdffaa", "ex4");

# The next password after ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed.
ok(!is_invalid("ghjaabcc"), "ex5");
#takes too long
#is(find_valid("ghijklmn"), "ghjaabcc", "ex5");
 

### PART 2 ###

done_testing();

my $input = "vzbxkghb";
my $new_pw = find_valid($input);
print ("Part 1: " . $new_pw  . "\n");
print ("Part 2: " . find_next_valid($new_pw). "\n");



