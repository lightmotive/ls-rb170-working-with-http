#!/bin/bash

echo -n 'Chocolate? '
read eat_chocolate

if [[ $eat_chocolate == y* ]]
then
  echo 'Yum!'
else
  echo 'Are you feeling OK?'
fi

string='Hello'

# String not empty:
if [[ -n $string ]]
then
  echo $string
fi

# Equality:
integer1=10
integer2=10
if [[ $integer1 -eq $integer2 ]]
then
  echo $integer1 and $integer2 are the same!
fi

# File entry existence:
if [[ -e ./hello_world.sh ]]
then
  echo 'File exists'
fi

# One condition, otherwise ...:
integer=15
if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10
else
  echo $integer is not less than 10
fi

# Multiple tests:
integer=15
if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10
elif [[ $integer -gt 20 ]]
then
  echo $integer is greater than 20
else
  echo $integer is between 10 and 20
fi

# Both conditions are true:
integer=15
if [[ $integer -gt 10 ]] && [[ $integer -lt 20 ]]
then
  echo $integer is between 10 and 20
fi

# At least one condition is true:
integer=12
if ([[ $integer -lt 5 ]]) || [[ $integer -gt 10 ]]
then
  echo $integer is less than 5 or greater than 10.
fi

# Not:
integer=8
if !([[ $integer -lt 5 ]] || [[ $integer -gt 10 ]])
then
  echo $integer is between 5 and 10.
fi  
