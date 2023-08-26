#!/bin/bash

# Special variables gives special properties to the variables
# Ex: $0-$9, $?, $#, $*, $@

# echo "Executed Scriptname is : 06-Special_Variables.sh"   # This is hardcoding
echo "Executed scriptname is : $0"                          # $0 : Will give info of script name
echo "The city you are currently living in is $1"
echo "State which you are currently residing in $2"

# bash scriptname.sh arg1 arg2 arg3
# arg 1,2,3 will be the argument that will be comsidered during the script executing

