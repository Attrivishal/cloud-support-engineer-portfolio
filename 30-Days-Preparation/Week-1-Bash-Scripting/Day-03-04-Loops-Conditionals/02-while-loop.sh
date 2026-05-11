#/bin/bash
# while loop syntax:
      # while condition
      # do
      # command
      # done

# Example: print numbers from 1 to 5 using while loop
myvar=1

while [ $myvar -le 5 ]
do 
   echo $myvar
   myvar=$(($myvar + 1))
done



# Infinite loop
counter=1
while true;
do
   echo $"running $counter time"
   echo "Press [CTRL+C] to stop.."
   counter=$((counter+1))
   sleep 1
done

#if file exists

while [ -f "myfile.txt" ]
do 
   echo "file exists"
   sleep 1  
done
echo "file does not exist"

#coutdown from 10 to 1
counter=10
while [ $counter -gt 0 ]
do 
   echo $counter
   counter=$((counter-1))
   sleep 1
done
echo "BOOOOOOOMMMMMMMM!!!!!!!!->>>>Blast off!"

#print even and odd number from 2 to 50 
counter=2
while [ $counter -le 50 ]
do 
   if [ $((counter % 2)) -eq 0 ]
   then
      echo "$counter is even"
   else
      echo "$counter is odd"
   fi
   counter=$((counter+1))
   sleep 0.5
done

#Question: Write a while loop that keeps asking "Are you ready?" until the user types "yes".

answer="no"
while [ "$answer" != "yes" ];
 do 
   read -p "Are you ready? " answer
done
echo "Great! Let's get started!"


#Question: Write a script that waits for a file called /tmp/cloud_ready.txt to appear. Check every 2 seconds. When found, print "Cloud resources are ready!"

echo "Wait for cloud resource to be ready..."

while [ ! -f "/tmp/cloud_ready.txt" ]
do 
   echo "checking for cloud_ready.txt..."
   sleep 2
done
echo "Cloud resources are ready!"   


#Question: Keep checking if https://example.com is reachable (use curl). Check every 3 seconds. Once reachable, print "Service is up!".

echo "Checking if the service is up or not ..."

while ! curl https://google.com &>/dev/null;
do
      echo "Service is not reac hable yet. checking again in 3 seconds..."
      sleep 3
done 
echo "Service is up!"


#Ask user for cloud region until valid
valid_region="us-east-1 us-west-2 eu-west-1 ap-southeast-1"
#read from user
read -p "Enter the region you want to choose:" region 
if echo "$valid_region" | grep -w "$region" ;
then 
     echo "Valid $region found!"
else
      echo "Invalid region. Please try again."
fi


#Ask user for input until they provide a non-empty string. If the input is empty, print "Input is empty. Please enter something." and ask again.
read -p "Enter something:" input
if [ -z "$input" ]
then 
   echo "Input is empty. Please enter something."
else
   echo "You entered: $input"
fi


#Ask user for a number of seconds. Countdown from that number to 0, printing each second, then print "Time's up!".

read -p "Enter the number of seconds for countdown:" seconds

while [ $seconds -gt 0 ]
do 
    echo "Secods remaining: $seconds"
    seconds=$((seconds-1))
    sleep 1
done
echo "Time's up!"

#Ask user for a username. Keep asking until they enter only letters and numbers (no spaces, no special characters). Use regex ^[a-zA-Z0-9]+$.
read -p "Enter the username:" username


while [[ ! $username =~ ^[a-zA-Z0-9]+$ ]]
do 
      echo "Invalid username should contain only letters and numbers. Please try again."
      read -p "Enter the username:" username
done
echo "Valid username: $username" 

