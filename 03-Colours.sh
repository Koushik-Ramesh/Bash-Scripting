#!/bin/bash

#Each and every colour we see on terminal will have a color code and we need to use it based on our need

# Colors            #Foreground     #Background
# Black             30	                40
# Red	            31	                41
# Green	            32	                42
# Yellow            33	                43
# Blue	            34	                44
# Magenta	        35	                45  
# Cyan	            36	                46
# Light Gray	    37	                47
# Gray	            90	                100
# Light Red	        91	                101
# Light Green	    92	                102
# Light Yellow	    93	                103
# Light Blue	    94	                104
# Light Magenta	    95	                105
# Light Cyan	    96	                106
# White	            97	                107

# syntax to print the color: echo -e "\e[COLORCODEm Your message to be printed in color \e[0m"
echo -e "\e[34m let this be in blue color \e[0m"
echo -e "\e[33m This is yellow \e[om"
