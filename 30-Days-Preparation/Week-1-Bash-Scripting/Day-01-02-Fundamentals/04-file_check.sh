#!/bin/bash

read -p "Enter the file name:" filename
if [ -e "$filename" ];
then
    echo "The file $filename exists."
else
    echo "The file $filename does not exist."
fi

# check command exist or not
#-v is used to check if the command exists in the system or not

command=htop
if command -v "$command" &>/dev/null ;
then
    echo "htop is installed at: $(command -v "$command")"
else
    echo "htop is not installed at: $(command -v "$command")"
    brew install $command
fi


# "Write a bash script that installs a package using brew and checks if the installation was successful. If successful, display the installation path of the package."

package=htop
brew install $package
if [ $? -eq 0 ];
then 
    echo "The installation of $package was successful."
    echo "The new comamnd is available here:"
    which $package
else
    echo "$package failed to install."
fi

 
 #Write a script that checks if your Mac has internet access by pinging google.com

ping -c 4 google.com &>/dev/null
 
 if [ $? -eq 0 ];
 then 
     echo "Your mac has internet access."
else
    echo "Your mac does not have internet access."
fi

# Great question! Here's how to take user input for a website and check connectivity.
read -p "Enter the website name you want to check (e.g., google.com): " website
echo "Checking connectivity to $website..."
ping -c 4 "$website" &>/dev/null
 
if [ $? -eq 0 ];
then 
    echo "Your mac has internet access to $website."
else
    echo "Your mac does not have internet access to $website."
fi
