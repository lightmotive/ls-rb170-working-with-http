#!/bin/bash

counter=0
max=9

# Print `counter` while it's less than or equal to `max`:
while [ $counter -le $max ]
do
  echo $counter
  ((counter++))
done