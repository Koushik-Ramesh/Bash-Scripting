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

example(){
    echo Going great 
    echo Keep it up
}

example

echo example call is completed

example
