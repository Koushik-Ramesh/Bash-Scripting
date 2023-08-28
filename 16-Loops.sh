#!/bin/bash

# Loops are basically the commands that will be executing for certain number of times

# There are 2 major Loops
<<COMMENT
1. For Loop: When the user knows the number of times the command must be executed, for loop is used
2. While Loop: When the user doesn't know for how many times the commands shou;d be executed, while loop is used
COMMENT

# For Loop Syntax:
    for val in 10 20 30 40 50 ; do
        echo " Value of the loop is: $val"
    done