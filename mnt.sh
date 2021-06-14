#!/bin/bash

#mounting script

sudo bash

/usr/testbed/bin/mkextrafs /mnt 

wait

exit

grep MemTotal /proc/meminfo

#^checking if the mounting worked should be 16384000

