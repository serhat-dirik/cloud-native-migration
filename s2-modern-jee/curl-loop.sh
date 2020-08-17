#! /bin/bash

echo "Calling " $1
while true
do
  curl -s -o /dev/null -w "%{http_code}" $1;echo ""
  sleep 1
done
