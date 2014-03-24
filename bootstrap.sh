#!/usr/bin/env bash
dir=/mnt/webdata/www_files
if [[ ! -e $dir ]]; then
    mkdir -p $dir
    chmod 777 $dir -R
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi

dir=/mnt/webdata/www_tmp
if [[ ! -e $dir ]]; then
    mkdir -p $dir
    chmod 777 $dir -R
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi

file=/etc/php5/apache2/php.ini
if [[ ! -d $file ]]; then
	sed -i 's/memory_limit = .*/memory_limit = 512M/' $file
	service apache2 reload
fi
