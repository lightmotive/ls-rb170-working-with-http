#!/bin/bash

numbers='1 2 3 4 5 6 7 8 9 10'

# Print each space-separated value in `numbers`
for number in $numbers
do
  echo $number
done

for letter in {a..z}
do
  printf $letter
done
echo

for fixnum in {01..10}
do
  echo $fixnum
done