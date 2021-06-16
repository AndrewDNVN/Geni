#!/bin/bash

#mounting script

/usr/testbed/bin/mkextrafs /mnt 

wait

awk '/MemTotal/ { print $2 }' /proc/meminfo
#^checking if the mounting worked should be 16384000

