#!/bin/bash

#Create symbol link for shell script
#chmod +x duration.sh  
#sudo ln -s /Users/ruberlei/Documents/GitHub/Shell\ Scripts/duration.sh  /usr/local/bin/duration

#In MacOS using --> brew install ffmpeg

#-e stop on the first error.
set -e

#Variable total time 
TOTAL_TIME=0

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#Loop in current directory and search files *.mp4;
for file in $(ls */*.mp4); do
    duration=$(ffprobe -i $file -show_entries format=duration -v quiet -of csv="p=0")
    TOTAL_TIME=$(echo $TOTAL_TIME + $duration | bc)
done

echo "Total hours.minutes $(echo "scale=2; ($TOTAL_TIME / 60 / 60)" | bc -l)"
IFS=$SAVEIFS