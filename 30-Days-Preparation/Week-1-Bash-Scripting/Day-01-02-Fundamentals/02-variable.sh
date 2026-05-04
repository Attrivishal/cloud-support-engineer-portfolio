#!/bin/bash

#Q4. Change Variable Value
# create a variable fruit = Apple
# Then change it to Mango and print it.
fruit="Mango"

echo "My favourite fruitis: $fruit"


#-----------------------------LEVEL-2-----------------------------
# Q5. User Input Name
#Take user input and store in variable name
#Print:
#Hello <name>

read -p "Enter your name:" name
echo "Hello: $name"



# Q6. Input + Age
# Ask user for age and print:
# You are <age> years old

read -p "Enter your age:" age
echo "you are $age years old"

#Q7. Full Sentence
# Take input:
#name
#city
#Print:
#<name> lives in <city>

read -p "Enter your name:" name
read -p "Enter your city:" city 
echo "$name lives in $city"

#------------------------------LEVEL-3-----------------------------
#Q8. Add Two Numbers
#Take two numbers as input and print their sum
read -p "Enter first number:" num1
read -p "Enter second number:" num2
sum=$((num1+num2))
echo "The sum of $num1 and $num2 is: $sum"

#Q9. Swap Two Variables
#Take two variables:
#a=10
#b=20
#Swap them and print new values

a=10
b=20

temp=$a
a=$b
b=$temp

echo "after swapping the. values are: a=$a and b=$b"

#Q10. Combine Variables
#Create:
#firstName
#lastName
#Print full name using both

read -p "Enter your first name:" firstName
read -p "Enter your last name:" lastName
fullname="$firstName $lastName"
echo "Your full name is: $fullname"

#Q11. Length of Name
#Take a name as input and print its length
read -p "Enter your name:" name
length=${#name}
echo "The length of $name is: $length"

#Q13. Multiply Input
# Take a number and print its double
read -p "Enter the number:" num 
double=$((num * 2))
echo "Double of $num is $double"

