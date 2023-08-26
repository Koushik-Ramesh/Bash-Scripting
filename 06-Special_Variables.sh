#!/bin/bash

# Special variables gives special properties to the variables
# Ex: $0-$9, $?, $#, $*, $@

# echo "Executed Scriptname is : 06-Special_Variables.sh"   # This is hardcoding
echo "Executed scriptname is : $0"                          # $0 : Will give info of script name
echo "The city you are currently living in is $1"
echo "State which you are currently residing in $2"

# bash scriptname.sh arg1 arg2 arg3
# arg 1,2,3 will be the argument that will be comsidered during the script executing
# Pedling: Once arg 9 ends and if arg10 is considered then the arg10 will take the value of arg1

a=10
b=55
c=89

echo "Value of a is $a"
echo "value of b is $b"
echo "Value of c is $c"

echo $$     # $$ will print the Process-ID of the current process
echo $#     # $# will print the number of arguments used
echo $?     # $? will print the exit code of the last command

echo "Variables used $*" # $* will print the used variable
echo $@


