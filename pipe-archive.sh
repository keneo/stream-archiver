#!/bin/bash

file_prefix="${1:-var/file}"
time_group_resolution=10

while [ -z "$shutdown" ]
  do
    #echo "go" > /dev/stderr
    last_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    last_time_group=$(echo $last_time | cut -b 1-$time_group_resolution)
    file_name=$file_prefix.$last_time_group
    echo "new file: $file_name" > /dev/stderr

    if [ -e $file_name ] ; then
        i=0
        while [ -e $file_name.$i.bak ] ; do
            let i++
        done
        echo "mv $file_name $file_name.$i.bak" > /dev/stderr
        mv $file_name $file_name.$i.bak &> /dev/null
    fi


    while true
      do
        cat var/line_for_next_file 2> /dev/null && rm -f var/line_for_next_file
        read line || { shutdown=1 && break; }
        time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
        time_group=$(echo $time | cut -b 1-$time_group_resolution)
        if [ "$time_group" != "$last_time_group" ]; then
          #echo "new time group: $time_group" > /dev/stderr
          echo -e "$time\t$line" > var/line_for_next_file
          break
        else
          #echo "same time group: $time_group" > /dev/stderr
          echo -e "$time\t$line"
        fi
      done > $file_name
  done
