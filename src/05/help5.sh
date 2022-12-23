#!/bin/bash
count=1
while [ -n "$1" ]
do
    echo $count - $2, $1
    shift
    shift
    let count=$count+1
done    
echo etc up to 5