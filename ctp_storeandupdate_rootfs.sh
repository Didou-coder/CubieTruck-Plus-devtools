#!/bin/bash

stdrootfsname='linaro-desktop-trusty-14.04-v1.1.tar.gz'

#get version from version tracking
currentversion=$(cat versiontrack)
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

for archive in $(ls ../rootfs_source | grep $1);do
  newfilename=$(echo "../rootfs_source/$archive" | sed 's/'$currentversion'/'$newversion'/')
done

#storing filesystem status under new archive
bsdtar -czvf $newfilename binary

#installing new file system in $1 SDK
rm -f ../$1/rootfs/$stdrootfsname
cp $newfilename ../$1/rootfs/$stdrootfsname

#storing new version
echo $newversion > versiontrack

