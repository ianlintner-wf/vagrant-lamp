#!/usr/bin/env bash
dir=/mnt/webdata/ 
if [[ ! -e $dir ]]; then
    mkdir -p $dir
    chmod 777 $dir -R
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi

sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php5/apache2/php.ini
