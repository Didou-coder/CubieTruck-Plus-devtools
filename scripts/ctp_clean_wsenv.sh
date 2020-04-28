#!/bin/bash

#clean kernel
cd linux-3.4
make mrproper
cd ..

#clean intermediates and output
rm -rf build output

#clean flashin card utility
if [[ -e rootfs/card_flash_rootfs-v1.0.tar.gz ]]
then
  rm -f rootfs/card_flash_rootfs-v1.0.tar.gz
fi


