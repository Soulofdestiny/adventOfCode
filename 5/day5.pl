#!/usr/bin/perl
#title           :day5.pl
#description     :
#author          :mgriessmeier, okurz
#version         :who needs version when we have git?
#usage           :common, obvious, isn't it?
#==============================================================================

use strict;
use warnings;
use Test::More;
use autodie qw(:all);

sub is_nice {
    my $input = shift (@_);
    my @count_vowels = ($input =~ /[aeiou]/g);
    my $is_nice = ($input =~ qr/(.)\1/) && (@count_vowels >= 3) && (!($input =~ /(ab|cd|pq|xy)/));
    return $is_nice;
}

# For example:
# 
# ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.
ok(is_nice("ugknbfddgicrmopn"), "example1");
# aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.
ok(is_nice("aaa"), "example2");
# jchzalrnumimnmhp is naughty because it has no double letter.
ok(!is_nice("jchzalrnumimnmhp"), "example3");
# haegwjzuvuyypxyu is naughty because it contains the string xy.
ok(!is_nice("haegwjzuvuyypxyu"), "example4");
# dvszwmarrgswjxmb is naughty because it contains only one vowel.
ok(!is_nice("dvszwmarrgswjxmb"), "example5");

open(FILE, "day5.txt");
chomp(my @lines = <FILE>);
close FILE;
use List::Util qw(sum);
my $nice_count = sum map { is_nice($_) } @lines;
print("part1: " . $nice_count . " words are nice" . "\n\n");


### PART 2 ###

sub is_also_nice {
    my $input = shift (@_);
    my $is_nice = ($input =~ /(..).*\1/) && ($input =~ /(.).\1/);
    
}

# qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj) and a letter that repeats with exactly one letter between them (zxz).
ok(is_also_nice("qjhvhtzxzqqjkmpb"), "example6");


# xxyxx is nice because it has a pair that appears twice and a letter that repeats with one between, even though the letters used by each rule overlap.
ok(is_also_nice("xxyxx"), "example7");


# uurcxstgmygtbstg is naughty because it has a pair (tg) but no repeat with a single letter between them.
ok(!is_also_nice("uurcxstgmygtbstg"), "example8");


# ieodomkazucvgmuy is naughty because it has a repeating letter with one between (odo), but no pair that appears twice.
ok(!is_also_nice("ieodomkazucvgmuy"), "example9");
 
done_testing();

my $also_nice_count = sum map { is_also_nice($_) } @lines;
print("part2: " . $also_nice_count . " words are also nice" . "\n\n");


