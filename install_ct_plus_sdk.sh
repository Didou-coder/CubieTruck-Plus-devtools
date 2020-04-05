#!/bin/bash

# $1: name of the root fle system to be compiled

#Automated installation of required libraries for OS developement

setup='sudo apt-get install -y'

for library in $(cat ct_plus_library.lst); do
  $setup $library
done

# install basic sdk root
sudo mkdir /usr/local/ct-plus-linux-sdk
sudo mkdir /usr/local/ct-plus-linux-sdk/image_repo
sudo mkdir /usr/local/ct-plus-linux-sdk/rootfs_factory

#installing mega tools

currentdir=$(pwd)
cd /usr/local

# downloading tool
sudo wget https://megatools.megous.com/builds/experimental/megatools-1.11.0-git-20200404-linux-x86_64.tar.gz
# decompress tool
sudo tar -xzvf megatools-1.11.0-git-20200404-linux-x86_64.tar.gz

sudo mv megatools-1.11.0-git-20200404-linux-x86_64 megatools

sudo ln -s megatools/megatools /usr/bin/megatools

sudo mv megatools/.megarc $HOME/.megarc





