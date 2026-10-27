#!/bin/bash

set -e -u

if [ ! -d debian ]; then
	echo "Couldn't find debian/ directory."
	exit 1
fi

PKGNAME=$(dpkg-parsechangelog -S Source)
VERSION=$(dpkg-parsechangelog | grep -E '^Version:' | cut -f 2 -d ' ' \
    | cut -f -1 -d '-')

fakeroot ./debian/rules clean

tar -czf "../${PKGNAME}_${VERSION}.orig.tar.gz" \
    --exclude ".git" --exclude "debian" \
	--exclude "rust-vendor" \
    --xform "s/^\./${PKGNAME}-${VERSION}/" .
