#!/bin/bash
## Creating first function 

greet(){
    echo "Hello i am vishal attri."
}

greet


# system-info() {
#  echo "Memory is:-"
#  df -h
#  echo "------------"

#  echo "Free memory is:-"
#  free -h
#  echo "------------"

#  echo "disk usage is:-"
#  du -sh
# }

# system-info

#Function with arguments

greet_person() {
    echo "Hello $1,How are you doing?"
}

greet_person "Vishal Attri"
greet_person "Khushi"

#checking disk usage and free memory
mem_usage() {
    usage=$(du -sh / | awk 'NR==2  {print $5}' | sed 's/%//')
    echo "$usage"
}

mem_usages=$(mem_usage)
echo "Your disk is: $(mem_usages)% full"


#check the number if even or odd if even return 0 else return 1
is_even(){
    if [ $(( $1 % 2 )) -eq 0 ];then
    return 0
    else
    return 1
    fi
}
#function calling 
is_even 4
if [ $? -eq 0 ];
then
     echo "Number is even"
else
    echo "Number is odd"
fi


# get file size