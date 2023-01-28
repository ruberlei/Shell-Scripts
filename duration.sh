#!/bin/bash

#export PATH=/opt/homebrew/bin:$PATH
#Create symbol link for shell script
#chmod +x duration.sh  
#sudo ln -s /Users/ruberlei/Documents/GitHub/Shell\ Scripts/duration.sh  /usr/local/bin/duration

#In MacOS using --> brew install ffmpeg

#-e stop on the first error.
set -e

#getopts -d param read specific directory. Example: duration -d /Users/ruberlei/OneDrive/Cursos/Almoço\ com\ Oracle

while getopts d: param
do
    case "${param}" in
        d) directory=${OPTARG};;
    esac
done

if [ -z "$directory" ]; then
        echo 'Missing -d, Example: duration -d /Users/ruberlei/OneDrive/' >&2
        exit 1
fi

#Variable total time 
SUM_TIME=0
COUNT=0

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

shopt -s dotglob

for file in $(find $directory -name '*.mp4'); do 
    duration=$(ffprobe -i $file -show_entries format=duration -v quiet -of csv="p=0")
    SUM_TIME=$(echo $SUM_TIME + $duration | bc)
    ((COUNT=COUNT+1))
done

echo "In directory --> [$directory]" "contains $COUNT files *.mp4 and total time videos $(echo "scale=2; ($SUM_TIME / 60 / 60)" | bc -l) (hours.minutes)"

IFS=$SAVEIFS