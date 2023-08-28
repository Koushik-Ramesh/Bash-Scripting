#!/bin/bash

<<COMMENT
echo "Useless things"
echo "Its you"
a=43
COMMENT
b=54
echo $a
echo $b

# This is a example of multi-line comment, whatever we enclose in between <<COMMENT  COMMENT will be considered as comment and will not be executed
