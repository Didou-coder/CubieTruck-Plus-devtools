#!/bin/bash

# $1: Name of the distribution you want to work on

workspace='/usr/local/ct-plus-linux-sdk'

mkdir $workspace/$1

cd $workspace/$1

for tool in $(echo 'products tools binaries rootfs'); do
  git clone https://github.com/cubieboard/Cubietruck_Plus-$tool
  mv Cubietruck_Plus-$tool $tool
done


#kernel source choice

echo '  '
echo '  '
echo 'kernel source code origin: '
echo '  1: Original CubieTruck Plus depot'
echo '  2: Official Allwinner linux community depot'
read -p "your choice? " choice

case $choice in
  1) git clone https://github.com/cubieboard/Cubietruck_Plus-kernel-source
     mv Cubietruck_Plus-kernel-source linux-3.4
     ;;
  2) git clone https://github.com/allwinner-zh/linux-3.4-sunxi.git
     mv linux-3.4-sunxi linux-3.4
     ;;
  *) echo 'I am sorry, wrong choice, that was a pretty simple question.'
     echo 'If you cannot answer it maybe it`s time for you to give up building a linux OS'
     ;;
esac

# root fs choice
echo '  '
echo '  '
read -p 'Do you intend to flash the board`s eMMC? (yes/no)' flash

case $flash in
  yes) cp $workspace/rootfs_factory/card_flash_rootfs-v1.0.tar.gz $workspace/$1/rootfs/
       ;;
  *) echo 'assuming no was the answer'
     ;;
esac



