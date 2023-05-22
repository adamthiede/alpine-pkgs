#!/bin/sh
git pull

mydir=$(pwd)
failfile='/tmp/alpine-pkgs-build-status'
cat /dev/null > $failfile

error() {
	echo "ERROR $1" >> $failfile
}

geterror() {
	grep ERROR $failfile
	if [[ $? == 1 ]];then
		exit 0
	else
		exit 1
	fi
}

for dir in ./*/* ; do
	cd $dir
	abuild checksum || error $(basename $dir)
	abuild -r || error $(basename $dir)
	cd $mydir
done

geterror

