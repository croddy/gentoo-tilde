#!/bin/sh
echo "recent_emerges=`
  ls -dtr /var/db/pkg/*/* |
  tail -n 10 |
  cut -d/ -f 5-6 |
  sed -e ':a;N;$!ba;s/\n/,/g'`"
