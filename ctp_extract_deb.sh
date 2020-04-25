#!/bin/bash

echo '#!/bin/bash' > postinst
echo '#general installation script' >> postinst
echo '  ' >> postinst
echo 'chroot binary' >> binary

for package in $(ls *.deb); do
  dir=$(echo $package | cut -d '_' -f1)
  mkdir $dir
  dpkg-deb -x $package binary
  dpkg-deb -e $package $dir
  echo '#'$package' postinst' >> postinst
  cat $dir/postinst >> postinst
  echo '  ' >> postinst
  rm -rf $dir
done

echo 'exit' >> postinst

chmod +x postinst


