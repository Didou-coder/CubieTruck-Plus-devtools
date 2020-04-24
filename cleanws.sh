#!/bin/bash

#clean kernel
cd linux-3.4
make mrproper
cd ..

#clean intermediates and output
rm -rf build output

