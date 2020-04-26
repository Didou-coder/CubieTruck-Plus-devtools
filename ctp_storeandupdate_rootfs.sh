#!/bin/bash

stdrootfsname='linaro-desktop-trusty-14.04-v1.1.tar.gz'

#get version from version tracking
currentversion=$(cat ../$1/rootfs_versiontrack)
major=$(echo $currentversion | cut -d '.' -f1 | sed 's/v//')
minor=$(echo $currentversion | cut -d '.' -f2)

if [[ $2 != '' ]]
then
  let "major++"
  minor='0'
else
  let "minor++"
fi

newversion="v$major.$minor"

newfilename=$(echo $stdrootfsname | sed 's/linaro-desktop-trusty/'$1'/')
newfilename=$(echo $newfilename | sed 's/v1.1/'$newversion'/')

#storing filesystem status under new archive
bsdtar -czvf '../rootfs_source/'$newfilename binary

#installing new file system in $1 SDK
rm -f ../$1/rootfs/$stdrootfsname
cp '../rootfs_source/'$newfilename ../$1/rootfs/$stdrootfsname

#storing new version
echo $newversion > ../$1/rootfs_versiontrack

