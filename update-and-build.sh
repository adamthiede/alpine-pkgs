#!/bin/sh
git pull
mydir=$(pwd)
for dir in ./*/* ; do
	cd $dir
	abuild checksum
	abuild -r
	cd $mydir
done

