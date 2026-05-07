#!/bin/bash

# Scenario: A customer says their server is "slow." Task: Write a script called diagnose.sh that:

# Prints the top 5 memory-consuming processes.
# Checks if the nginx (or any web server) process is actually running.
# Checks the last 10 lines of the system log (/var/log/syslog or /var/log/system.log on Mac) for the word "error.


echo "====================================="
echo "              SERVER DIAGNOSIS       "
echo "====================================="


echo "Top 5 Memory-Consuming Processes:"

ps aux --sort=-%mem | head -6
echo "====================================="

echo "Checking if web server is running..."
if systemctl is-active --quiet nginx 2>/dev/null;
then 
    echo "nginx is running"
else
    echo "nginx is not running"
fi
echo "====================================="
echo "Checking system logs for errors..."
 sudo tail -10 /var/log/syslog | grep -i "error" || echo "No recent errors found in system logs."
echo :"====================================="
echo "Diagnosis complete. Please review the above information for potential issues."
echo "====================================="