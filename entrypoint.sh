#!/bin/bash
/usr/local/lsws/bin/lswsctrl start > /dev/null
sleep 2
echo " * openlitespeed. [OK]"
exec "$@"
