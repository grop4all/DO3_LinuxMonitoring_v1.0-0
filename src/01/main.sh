#!/bin/bash

if [ -n "$1" ] ; then
    if [[ $1 =~ ^[0-9]+([.][0-9]+)?$ ]] ; then
        echo "Number not used to arg"
    else 
        echo "OK"
    fi
else
    echo "No found args"
fi
