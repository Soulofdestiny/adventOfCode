#!/usr/bin/env python
#title           :day8.py
#description     :
#author          :mgriessmeier
#date            :
#version         :0.1
#usage           :python day8.py
#notes           :
#python_version  :
#==============================================================================

import re



def count_literals(line):
    return len(line)


def count_memory(line):
    return len(eval(line))


def count_all(line):
    return count_literals(line) - count_memory(line)



#"" is 2 characters of code (the two double quotes), but the string contains zero characters.
assert (count_literals('""') == 2)
assert (count_memory('""') == 0)
assert (count_all('""') == 2)

#"abc" is 5 characters of code, but 3 characters in the string data.
line = '"abc"'
assert (count_literals(line) == 5)
assert (count_memory(line) == 3)
assert (count_all(line) == 2)

#"aaa\"aaa" is 10 characters of code, but the string itself contains six "a" characters and a single, escaped quote character, for a total of 7 characters in the string data.
#line = '"aaa\"aaa"'
# but for correct input we need to escape it once more
line = r'"aaa\"aaa"'
#line = open("day8-p1-e2.txt").readline().rstrip()
assert (count_literals(line) == 10)
assert (count_memory(line) == 7)
assert (count_all(line) == 3)

#"\x27" is 6 characters of code, but the string itself contains just one - an apostrophe ('), escaped using hexadecimal notation.
line = r'"\x27"'
assert (count_literals(line) == 6)
assert (count_memory(line) == 1)
assert (count_all(line) == 5)


file = "day8"
lines = [line.rstrip() for line in open(file).readlines()]
my_sum = sum([count_all(line) for line in lines])

print("Part 1: %s" % my_sum)



def encode(line):
    return '"' + re.escape(line) + '"'

def count_encoded(line):
    return len(encode(line)) - len(line)


# "" encodes to "\"\"", an increase from 2 characters to 6.
line = r'""'
assert (len(encode(line)) == 6)
assert (count_encoded(line) == 4)

# "abc" encodes to "\"abc\"", an increase from 5 characters to 9.
line = r'"abc"'
assert (len(encode(line)) == 9)
assert (count_encoded(line) == 4)

# "aaa\"aaa" encodes to "\"aaa\\\"aaa\"", an increase from 10 characters to 16.
line = r'"aaa\"aaa"'
assert(len(line) == 10)
assert (len(encode(line)) == 16)
assert (count_encoded(line) == 6)

# "\x27" encodes to "\"\\x27\"", an increase from 6 characters to 11.
line = r'"\x27"'
assert (len(encode(line)) == 11)
assert (count_encoded(line) == 5)


my_sum = sum([count_encoded(line) for line in lines])

print("Part 2: %s" % my_sum)







