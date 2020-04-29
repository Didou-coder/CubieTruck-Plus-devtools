#!/bin/bash

WORKSPACE=$(for pardir in $(pwd | sed 's/\//\n/g');do prtdir=$pardir;done; echo $prtdir)

TARGET=$(cat makeimage | grep TARGET= | cut -d '=' -f2)

VERSION='v'$(cat makeimage | grep VERSIONIMG= | cut -d '=' -f2)

echo -e 'Building Target '$TARGET'\n' > lasttarget.log

function build-tfcard {
  echo "**********************************"
  echo "Starting buiding kernel for card"
  echo " "
  cb_build_card_image >> lasttarget.log
  echo " "
  echo "Build done"
  echo "**********************************"
  echo "Starting partitioning for card"
  echo " "
  cb_part_install_tfcard sdb pack >> lasttarget.log
  echo " "
  echo "Partitioning done"
  echo "**********************************"
  echo "Starting instaling card"
  echo " "
  cb_install_tfcard sdb pack >> lasttarget.log
  echo " "
  echo "Installation done"
  echo "**********************************"
}

function build-emmc {
  echo "**********************************"
  echo "starting buiding kernel for emmc"
  echo " "
  cb_build_flash_card_image >> lasttarget.log
  echo " "
  echo "Build done"
  echo "**********************************"
  echo "Starting partitioning for card"
  echo " "
  cb_part_install_flash_card sdb pack >> lasttarget.log
  echo " "
  echo "Partitioning done"
  echo "**********************************"
  echo "Starting instaling emmc flash img"
  echo " "
  cb_install_flash_card sdb pack >> lasttarget.log
  echo " "
  echo "Installation done"
  echo "**********************************"
}

function flashfs {
  echo "**********************************"
  echo "Installing rootfs flash system"
  echo " "
  cp ../rootfs_source/card_flash_rootfs-v1.0.tar.gz rootfs/card_flash_roots-v1.0.tar.gz >> lasttarget.log
  echo " "
  echo "Installation done"
  echo "**********************************"
}

SECONDS=0
echo -e "Starting making of target: "$TARGET

targetfile="../image_repo/${WORKSPACE}_cubietruck-plus-${TARGET}_${VERSION}.img"


case $TARGET in
  card-hdmi) build-tfcard
             echo "Storing micro-SD image"
             echo " "
             mv output/cb5/cb5-linaro-desktop-hdmi/cb5-cb5-linaro-desktop-hdmi-tfcard.img $targetfile
             ;;
  card-dp) build-tfcard
           echo "Storing micro-SD image"
           echo " "
           mv output/cb5/cb5-linaro-desktop-dp/cb5-cb5-linaro-desktop-dp-tfcard.img $targetfile
           ;;
  emmc-hdmi) flashfs
             build-emmc
             echo "Storing micro-SD image"
             echo " "
             mv output/cb5/cb5-linaro-desktop-hdmi/cb5-linaro-desktop-hdmi-tf_flash_emmc.img $targetfile
             ;;
  emmc-dp) flashfs
           build-emmc
           echo "Storing micro-SD image"
           echo " "
           mv output/cb5/cb5-linaro-desktop-dp/cb5-linaro-desktop-dp-tf_flash_emmc.img $targetfile
           ;;
  *) echo "Wrong target!"
     ;;
esac

time=$SECONDS
let "heure=$time/3600"
let "reste=$time-$heure*3600"
let "minutes=$reste/60"

echo " "
echo "Image stored"

if [[ -e $targetfile ]]
then
  #updating maketarget version
  version=$(cat makeimage | grep VERSIONIMG=)
  num=$(echo $version | cut -d '=' -f2)
  let "num++"
  if [[ $num < 10 ]]
  then
    num=0$num
  fi

  sed -i 's/'$version'/VERSIONIMG='$num'/' makeimage

  success="with success "
else
  success="without success "
fi

if [[ $heure == 0 ]]
then
  echo "Process complete ${success}in ${minutes}m"
else
  echo "Process complete ${success}in ${heure}h${minutes}m"
fi
echo "**********************************"


