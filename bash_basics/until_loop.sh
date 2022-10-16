#!/bin/bash

counter=0
max=9

# Print `counter` until it exceeds `max`:
until [ $counter -gt $max ]
do
  echo $counter
  ((counter++))
done