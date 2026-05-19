#!/bin/bash
#Function that check that person is adult or not 

is_adult() {
    age=$1
     
     if [ $age -ge 19 ];
     then 
         return 0
    else 
        return 1
    fi
}

#using the function 
is_adult 22
#return value
if [  $? -eq 0 ];
then
    echo "You can enter into the room,WHOAaa"
else 
    echo "You cannot enter in the room,Soory!"
fi

