#!/bin/bash

#What is variable ? It is generally used to hold some values dynamically

# for ex: a=10, b=Hii - in this a&b are variables used to hold values 10 and xyz respectively
a=10
b=hii 
# There is no concept of data types in linux or shellscripting
# By default, everything is a string

# If an input conains special characters, enclose with the double quotes

# How to print the values of the variable ? - Using special charactes, we will be printing the values of the variable
# echo $a

echo "Printing the value of a : $a"     # $a and ${a} both are same - Prefer using flower brackets
echo "Print a : ${a}"
