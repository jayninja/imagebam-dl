#!/bin/bash/
# usage : ./imagebam-dl.sh <URL>

if [ -z "$1" ]
then 
  echo "usage : ./imagebam-dl.sh <URL>"
  exit 1;
fi

DIRECTORY_NAME=`basename $1`
mkdir -p ./$DIRECTORY_NAME

for i in `curl -s "$1" |grep 'a href'| egrep -o "http.*" |grep /image/ | cut -d "'" -f1 | cut -d '"' -f1` ; 
do 
  DIRECT_IMAGE_URL=`curl -s "$i" | grep og:image | cut -f4 -d'"'`
  FILENAME=`basename $DIRECT_IMAGE_URL`
  wget -O ./$DIRECTORY_NAME/$FILENAME $DIRECT_IMAGE_URL 
done
