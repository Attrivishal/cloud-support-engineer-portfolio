#!/bin/bash

#
#Q1. CHECK if number is equal of not 

read -p "Enter a number:" num

if [ $num -eq 20 ];
then 
    echo "The number is equal to 20"
else 
    echo "The number is not equal to 20"
fi

#Q2. CHECK if number is even or odd

read -p "Enter a number:" num
if [ $num -eq 0 ];
then 
    echo "The number is zero"
elif [ $(( num % 2 )) -eq 0 ];
then 
    echo "The number is even"
else 
    echo "The number is odd"
fi

# ------IMPORTANT NOTE------
# we are using double parentheses $(()) for arithmetic operations

# Q3. check files 
read -p "Enter the file name:" filename
if [ -e "$filename" ];
then
    echo "The file $filename exists."
else
    echo "The file $filename does not exist."
fi  
