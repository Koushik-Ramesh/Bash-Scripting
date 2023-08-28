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
        echo "\e[32m Starting the service \e[0m"
        ;;
    stop)
        echo "\e[90m Stopping the service \e[0m"
        ;;
    restart)
        echo "\e[36m Restarting the service \e[0m"
        ;;
    *)
        echo "\e[31m Valid options are start, stop or restart \e[0m"
        echo "\e[31m Example: bash Scriptname restart \e[0m"
        ;;
esac


