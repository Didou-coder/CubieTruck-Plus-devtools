#!/bin/bash

# $1: name of the root fle system to be compiled

#Automated installation of required libraries for OS developement

setup='sudo apt-get install -y'

for library in $(cat ct_plus_library.lst); do
  $setup $library
done

# install basic sdk root
mkdir image_repo
chgroup vboxsf image_repo
mkdir rootfs_factory
mkdir rootfs_source
chgroup vboxsf rootfs_source








