#!/bin/bash

WORKSPACE=$(for pardir in $(pwd | sed 's/\//\n/g');do prtdir=$pardir;done; echo $prtdir)

TARGET=$(cat makeimage | grep TARGET= | cut -d '=' -f2)

VERSION='v'$(cat makeimage | grep VERSIONIMG= | cut -d '=' -f2)

echo -e 'Target Build Log\n' > lasttarget.log

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
  cp ../rootfs_source/card_flash_rootfs-v1.0.tar.gz rootfs/card_flash_roots-v1.0.tar.gz
  echo " "
  echo "Installation done"
  echo "**********************************"
}

SECONDS=0
echo -e "Starting making of target: "$TARGET

case $TARGET in
  card-hdmi) build-tfcard
             echo "Storing micro-SD image"
             echo " "
             mv output/cb5/cb5-linaro-desktop-hdmi/cb5-cb5-linaro-desktop-hdmi-tfcard.img ../image_repo/${WORKSPACE}_cubietruck-plus-card-hdmi_${VERSION}.img
             ;;
  card-dp) build-tfcard
           echo "Storing micro-SD image"
           echo " "
           mv output/cb5/cb5-linaro-desktop-dp/cb5-cb5-linaro-desktop-dp-tfcard.img ../image_repo/${WORKSPACE}_cubietruck-plus-card-dp_${VERSION}.img
           ;;
  emmc-hdmi) flashfs
             build-emmc
             echo "Storing micro-SD image"
             echo " "
             mv output/cb5/cb5-linaro-desktop-hdmi/cb5-linaro-desktop-hdmi-tf_flash_emmc.img ../image_repo/${WORKSPACE}_cubietruck-plus-emmc-hdmi_${VERSION}.img
             ;;
  emmc-dp) flashfs
           build-emmc
           echo "Storing micro-SD image"
           echo " "
           mv output/cb5/cb5-linaro-desktop-dp/cb5-linaro-desktop-dp-tf_flash_emmc.img ../image_repo/${WORKSPACE}_cubietruck-plus-emmc-dp_${VERSION}.img
           ;;
  *) echo "Wrong target!"
     ;;
esac

echo " "
echo "Image stored"
time=$SECONDS
let "heure=$time/3600"
let "reste=$time-$heure*3600"
let "minutes=$reste/60"
if [[ $heure == 0 ]]
then
  echo "Process complete in ${minutes}m"
else
  echo "Process complete in ${heure}h${minutes}m"
fi
echo "**********************************"

