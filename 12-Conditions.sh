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
        echo "Starting the service"
        ;;
    stop)
        echo "Stopping the service"
        ;;
    restart)
        echo "Restarting the service"
        ;;
    *)
        echo "Valid options are start, stop or restart"
        ;;
esac


