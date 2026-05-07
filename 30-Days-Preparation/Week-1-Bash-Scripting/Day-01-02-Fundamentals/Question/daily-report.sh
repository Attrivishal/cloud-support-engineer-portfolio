#!/bin/bash

# Daily Report Script
TODAY=$(date +"%Y-%m-%d")

REPORT="report-$TODAY.txt"

#combine everything 
{
    echo "Date: $TODAY"
    echo "files: $(ls /home | wc -l)"
    echo "disk usage:"
    df -h
} > "$REPORT"

echo "Daily report generated: $REPORT"