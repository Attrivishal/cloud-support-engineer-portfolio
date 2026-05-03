#!/bin/bash

# This script demonstrates the use of variables in bash scripting.
# always use double quotes when referencing variables

now=$(date)
echo "Current date and time: $now"
Name="vishal"
age=21
University="LPU"
Course="BCA"

echo "My name is $Name, I am $age years old , and I am currently pursuing $Course from $University , thank you for asking :)"

#why we exactly use variable in production environment?
#1. Reusability: Variables allow you to reuse values throughout your script without hardcoding them multiple times. This makes your code more efficient and easier to maintain.


#Write code to store the output of date command in a variable called today

#!/bin/bash

today=$(date)
echo "todays date is: $today"