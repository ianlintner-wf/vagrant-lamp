#!/usr/bin/env bash
dir=/mnt/webdata/ 
if [[ ! -e $dir ]]; then
    mkdir -p $dir
    chmod 777 $dir -R
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi
