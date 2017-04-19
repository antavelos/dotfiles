
#!/bin/bash

# to be used as symlink under /usr/share/i3blocks

echo `xbacklight|awk '{printf("%.0f%", $1)}'`
