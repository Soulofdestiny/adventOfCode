#!/usr/bin/python
current = 0
position = 0
hitFloor = 0
with open('day1') as file:
    for line in file:
        for ch in line:
            if (current == -1) and (hitFloor == 0):
                index = position
                hitFloor = 1;
            if ch == "(":
                print "pos: %s, current floor: %s" % (position, current)
                current += 1
                position += 1
            elif ch == ")":
                print "pos: %s, current floor: %s" % (position, current)
                current -= 1
                position += 1
print "Part 1 - current floor: %s" % current
print "Part 2 - index when floor '-1' was hit: %s" % index

