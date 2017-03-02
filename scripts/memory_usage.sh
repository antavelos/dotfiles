#!/bin/bash

# to be used as symlink under /usr/share/i3blocks

echo `vmstat -s|head -2|tail -1|awk '{printf("%.1fG", ($1/1024)/1024)}'`
