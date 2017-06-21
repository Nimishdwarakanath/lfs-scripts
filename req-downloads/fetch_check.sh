#!/bin/bash
mkdir community-suggested-patches/ patches/ packages/
rm -v check-packages-list check-patches-list
 #fetch packages
wget --input-file=wget-list-packages --continue --directory-prefix=./packages
md5sum ./packages/* | awk '{print $1}' >> check-packages-list #works because the list of packages are in alphabetical order
 #md5sum comparison of packages
pakages_list=`echo {1..70}`
echo "check sum doesn't match for the following package downloads"
for i in $packages_list
do
 a=`sed -n "$i p" md5sum-packages-list`
 b=`sed -n "$i p" check-packages-list`
 if [ "$a" != "$b" ]
 then
  line=$(($i*3-2))
  sed -n "$line p" list-packages
 fi
done
 #fetch patches
wget --input-file=wget-list-patches --continue --directory-prefix=./patches/
md5sum ./patches/* | awk '{print $1}' >> check-patches-list #works because the list of packages are in alphabetical order
patches_list=`echo {1..7}`
echo "check sum doesn't match for the following patch downloads"
for i in $patches_list
do
 a=`sed -n "$i p" md5sum-patches-list`
 b=`sed -n "$i p" check-patches-list`
 if [ "$a" != "$b" ]
 then
  line=$(($i*3-2))
  sed -n "$line p" list-patches
 fi
done
 #fetch community curated patches
wget --directory-prefix=./community-suggested-patches -r -np -nH --cut-dirs=3 -R "index.html*" http://www.linuxfromscratch.org/patches/downloads/
