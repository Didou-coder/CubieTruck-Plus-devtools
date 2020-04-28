#/bin/bash

for pardir in $(pwd | sed 's/\//\n/g');do prtdir=$pardir;done; echo $prtdir


