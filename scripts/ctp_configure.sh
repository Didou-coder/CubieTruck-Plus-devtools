#!/bin/bash

target=$1

case $target in
  *-hdmi) echo -e '0\n1\n' > target.conf
          source tools/scripts/envsetup.sh < target.conf
          ;;
  *-dp) echo -e '0\n0\n' > target.conf
        source tools/scripts/envsetup.sh < target.conf
        ;;
  *) echo 'Keeping last target!'
     target=$(cat makeimage | grep TARGET= | cut -d "=" -f2)
     ;;
esac

if [[ -e target.conf ]];then
  rm -f target.conf
fi

sed -i 's/TARGET=.*/TARGET='$target'/g' makeimage

#updating maketarget version
version=$(cat makeimage | grep VERSIONIMG=)
num=$(echo $version | cut -d '=' -f2)
let "num++"
if [[ $num < 10 ]]
then
  num=0$num
fi

sed -i 's/'$version'/VERSIONIMG='$num'/' makeimage

#clean usb key
echo ' '
read -p "Veuillez insérer un cléusb et la connecter à la machine virtuelle"

umount /dev/sdb1
umount /dev/sdb2

echo -e 'o\nw\n' | fdisk /dev/sdb
sync
echo -e 'n\np\n1\n\n\nw\n' | fdisk /dev/sdb
sync
mkfs.ext4 /dev/sdb1

umount /dev/sdb1


