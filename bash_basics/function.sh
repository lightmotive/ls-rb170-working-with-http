#!/bin/bash

# Define `greeting` function:
greeting () {
  # Output "Hello " followed by first arg:
  echo "Hello $1"
  # Output "Hello " followed by second arg:
  echo "Hello $2"
}

# Invoke `greeting` function with two string args, Peter and Paul:
greeting 'Peter' 'Paul' # outputs 'Hello Peter' 'Hello Paul' on separate lines
greeting 'Peter'        # outputs 'Hello Peter' 'Hello ' on separate lines