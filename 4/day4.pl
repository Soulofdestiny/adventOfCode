#!/usr/bin/perl
        #title           :day4.pl
#description     :
#author          :mgriessmeier
#date            :
#version         :0.1
#usage           :perl day4.pl
#notes           :
#perl_version  :  
#==============================================================================

use strict;
use warnings;
use Test::More;
use Digest::MD5 qw(md5_hex);

my $input = "iwrupvqb";


sub find_lowest($$) {
    my ($input, $pattern) = (@_);
    my $min_sum = "ffffffffffffffffffffffffffffffff"; 
    my $min_i = 0;
    my $i = 0;
    my $md5_sum = 0;
    do {
        my $md5_sum = compute_md5($input . sprintf("%06u",$i ));
        if ($md5_sum lt $min_sum) {
            $min_sum = $md5_sum;
            $min_i = $i;
            print "new min found: " . $min_i . ", hash: " . $min_sum . " ran: " . $i . " times \n";
        }
        $i++;
        #} until $min_sum =~ qr/^00000/; 
    } until $min_sum =~ qr/^$pattern/; 
    return $min_i;
}

sub compute_md5 {
    my $input = shift(@_);
    return md5_hex($input);
}

# If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.

my $inp1 = "abcdef";
like(compute_md5($inp1 . 609043), qr/^000001dbbfa/, "example-1");
is(find_lowest($inp1, '00000' ), 609043, "example-1");


# If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....
my $inp2 = "pqrstuv";
like(compute_md5($inp2 . 1048970), qr/^000006136ef/, "example-2");
is(find_lowest($inp2, "00000"), 1048970, "example-2");

done_testing();

my $regexp1 = "00000";
my $part1_solution = find_lowest($input, $regexp1);

my $regexp2 = "000000";
my $part2_solution = find_lowest($input, $regexp2);

print "\nPart 1: " . $part1_solution;
print "\nPart 2: " . $part2_solution;
