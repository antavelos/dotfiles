#!/bin/bash

LAYOUT=`setxkbmap -query | grep layout|awk -F":    " '{print $2}'`

if [ $LAYOUT == 'us' ]
then
    setxkbmap gr
else
    setxkbmap us
fi
