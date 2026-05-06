#!/bin/bash 
# for loop syntax:

    # for var in list 
    # do
    # comamnd
    # done


for fruit in apple mango orange
do 
    echo "I like $fruit"
done

#CHECK if multiple servers is reachable or not
server=("google.com" "yahoo.com" "bing.com")

for server in "${server[@]}";
do 
   if ping -c 1 "$server" &> /dev/null;
   then 
        echo "$server is reachable"
   else
        echo "$server is not reachable"
   fi
done


#Restart service if it crashes if not installed then install it.
# service="nginx"
# if systemctl is-active --quiet "$service";
# then 
#     echo "$service is running"
# else 
#     echo "$service is not running"
#     if systemctl list-unit-files | grep -q "$service.service";
#     then 
#         echo "Restarting $service..."
#         systemctl restart "$service"
#     else 
#         echo "$service is not installed. Installing $service..."
#         apt-get update && apt-get install -y "$service"
#     fi
# fi


#sum number 1 to n 

read -p "enter a number:" n
sum=0
for ((i=1; i<=n; i++));
do 
    sum=$((sum + i))
done

echo "the sum of the number is: $sum"

