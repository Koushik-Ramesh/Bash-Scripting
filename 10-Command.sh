#!/bin/bash

# There are 4 types of commands
# 1. Binary Commands (/bin = regular commands, /sbin= commands used by root user)
# 2. Alias Commands (Shortcut commands)
# 3. shell Commands (Builtin commands ex: cd, break )
# 4. Functions (Set of commands that can be written in a sequence and called n number of times)

#How to call a function ?

#f()
#{
#    echo hi
#}

Stats(){
    echo "Sessions running are $(who | wc -l)" 
    echo "Date is $(date +%F)"
    echo "Average usage of system in last 5 mins is $(uptime | awk -F : '{print $NF}' | awk -F, '{print $2}')"
    # uptime | awk -F :{print $1 or $2 - NF will print final argument} | awk -F, {print $2}
    # -F = Field Separator (, for the field or : for the last field)
}

# Now lets call one function from another function

System(){
    echo You have used sytem for a long time
    echo Time to take a break

    Stats   # Calling the function 
}

System

