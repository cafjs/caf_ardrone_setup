#!/bin/ash

DIRNAME=${DIRNAME:-/data/video}

TARNAME=${TARNAME:-changes.tar.gz}

VERSION=`cat /update/version.txt`

if [ "$VERSION" == "2.3.3" ]
then
     echo "Applying tar file"
     #rm -fr /data/caf
     cd /
     tar xzvf ${DIRNAME}/${TARNAME}
else
    echo "Wrong firmware version: $VERSION see README.md to upgrade"
fi     
