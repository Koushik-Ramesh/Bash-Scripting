#!/bin/bash

DATE="$(date +%F)"

# Who in xshell : List the sessions that are running in the system
# wc -l : List the number of sessions

Sessions_Count="$(who | wc -l)"

echo -e "Today's Date is \e[33m $DATE \e[0m"
echo -e "Number of sessions running: \e[33m $Sessions_Count \e[0m"
