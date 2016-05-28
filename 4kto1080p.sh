#!/bin/bash

if ! [[ -d $2 ]]; then
    echo "bad output directory"
    exit 2
fi

function process_file {
    file=${1}
    base=${file%.*}
    name=${base##*/}
    ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -crf 20 -preset slow $2/${name}"_1080.mp4"
}

if [[ -d $1 ]]; then
    for file in `ls $1 | grep -i -e .mp4`
    do
	process_file "$1/$file" $2
    done
elif [[ -f $1 ]]; then
    process_file $1 $2
else
    echo "invalid argument"
    exit 1
fi



