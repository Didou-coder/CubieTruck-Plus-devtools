#!/bin/bash

target=$1

if [[ -z $target ]]
then
  echo 'Keeping last target!'
  target=$(cat makeimage | grep TARGET= | cut -d "=" -f2)
fi


case $target in
  *-hdmi) echo -e '0\n1\n' > target.conf
          source tools/scripts/envsetup.sh < target.conf
          ;;
  *-dp) echo -e '0\n0\n' > target.conf
        source tools/scripts/envsetup.sh < target.conf
        ;;
esac

if [[ -e target.conf ]];then
  rm -f target.conf
fi

sed -i 's/TARGET=.*/TARGET='$target'/g' makeimage

#clean usb key
echo ' '
read -p "Veuillez insérer un cléusb et la connecter à la machine virtuelle"

umount /dev/sdb1
umount /dev/sdb2

echo -e 'o\nw\n' | fdisk /dev/sdb
sync
echo -e 'n\np\n1\n\n\nw\n' | fdisk /dev/sdb
sync
mkfs.ntfs /dev/sdb1

umount /dev/sdb1


