#!/bin/bash

# if condition are available in 3 formats:
#    1. Simple if
#    2. If else
#    3. ELse if

# Ex:
<<COMMENT
     Simple if:
    if [expression]; then
        Commands
    fi
Commands will be executed only if the expression is true.
If the Expression is false, then commands wont be executed.

2. If else
    if [expression]; then
        Commands A
    else
        Commands B
    fi

Commands A will be executed only when the expression is true, if its false then Commands B will be executed

3. Else if

    if [expression A]; then

        Commands A

    elif [expression B]; then

        Commands B

    elif [expression C]; then

        Commands C

    else

        Commands D

    fi
COMMENT








