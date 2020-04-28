#!/bin/bash

# $1: Name of the distribution you want to work on

workspace=$(pwd)

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

#starting tracking of rootfs modifications
cp ../makeimage.template makeimage

#blacklisting workspace in extra tools git repository
echo $1 >> .gitignore

