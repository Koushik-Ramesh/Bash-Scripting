#!/bin/bash

# In Bash, Redirectors are of 2 types 
#   1. Input Redirector (Take input from the file): < (Ex: sudo mysql </tmp/studentapp.sql)
#   2. Output Redirector (Routing the output to the file): > or 1>  >> ( >> appends the latest output to the existing content)

# Outputs
# 1. Standard OUTPUT     >, >> or 1>
# 2. Standard Errpr     2> or 2>>
# 3. Standard output and standard error     &> or &>>

# ls -ltr  >  output.txt       # Redirects the output to output.txt
# ls -ltr  >> output.txt       # Redirects and appends the output to output.txt
# ls -ltr  2> output.txt       # Redirects the error only to output.txt
# ls -ltr  &> output.txt       # Redirects the output or error to output.txt


