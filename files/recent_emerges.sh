#!/bin/sh
echo "recent_emerges=`
  grep 'completed emerge' /var/log/emerge.log |
  cut -b 44- |
  cut -d\  -f1 |
  tail -n 10 |
  sed -e ':a;N;$!ba;s/\n/,/g'`"
