#!/usr/bin/env bash

for DD in `cat ./debian.txt` ;do
  echo $DD
  apt-get install -y $DD
  RV="$?"
  if [ $RV -eq 0 ];then
    echo "$DD installed" 
  elif [ $RV -eq 100 ];then
    echo "$DD not found, skip"
  else
    echo "$DD error"
    exit 1
  fi
done
