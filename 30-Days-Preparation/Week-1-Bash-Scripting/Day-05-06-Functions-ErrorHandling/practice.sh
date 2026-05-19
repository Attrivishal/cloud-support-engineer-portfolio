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

