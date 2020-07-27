#!/bin/bash

mkdir /u02/preprod_deployment/$(date +%d%m%Y)  ##everday it will create a folder  
sleep 9h                                       

DDMMYYYY="`date +%d%m%Y`"                      
loc="/u02/preprod_deployment/"$DDMMYYYY/       

for file in $loc/*.*; do                        ##this block will create folders which named deployment files. And it will move .rar files to related folders
    dir=${file%%.*}
    mkdir -p "$dir"
    mv "$file" "$dir"
    unrar x -r "$file" "${file%%.rar}"; 
done 








