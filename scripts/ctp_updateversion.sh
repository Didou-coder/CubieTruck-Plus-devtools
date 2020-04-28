#!/bin/bash

#updating makefile version
version=$(cat makefile | grep VERSION)
num=$(echo $version | cut -d 'v' -f2)
let "num++"
sed -i 's/'$version'/VERSION=v'$num'/' makefile

