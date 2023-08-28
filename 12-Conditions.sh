#!/bin/bash

# Conditions helps us to execute something only if the factor satisfies the condition or else not

# syntax
# case $var in
#    opt 1) Commands-x ;;
#    opt 2) Commands-y ;;
# esac

Action=$1

case $Action in
    start)
        echo -e "\e[32m Starting the service \e[0m"
        exit 0
        ;;
    stop)
        echo -e "\e[90m Stopping the service \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[36m Restarting the service \e[0m"
        exit 2
        ;;
    *)
        echo -e "\e[31m Valid options are start, stop or restart \e[0m"
        echo -e "\e[31m Example: bash Scriptname restart \e[0m"
        exit 3
        ;;
esac

# Exit 0,1,2... will let us know whether the command is executed properly or not
# TO check exot code : $?



