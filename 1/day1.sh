#!/bin/bash

MyString=$(cat day1)
op=0
cl=0
cnt=1
echo $MyString | awk -v ORS="" '{ gsub(/./,"&\n") ; print }' | \
    while read char
    do
        if [ "$char" = '(' ]
        then
            (( op += 1 ))
        fi
        if [ "$char" = ')' ]
        then
            (( cl += 1 ))
        fi
        (( cnt += 1 ))
    done

echo "count: $cnt"
echo "open: $op"
echo "close: $cl"
