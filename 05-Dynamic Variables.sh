#!/bin/bash

DATE="$(date +%F)"

# Who in xshell : List the sessions that are running in the system
# wc -l : List the number of sessions

Sessions_Count="$(who | wc -l)"

echo "Today's Date is $DATE "
echo "Number of sessions running: $Sessions_Count"
