#!/bin/bash
#
# Script to automate the build of a Node.JS debian package
#
# Copyright (c) 2013-2015 Alex Williams, Unscramble <license@unscramble.jp>
#
# License: MIT

VERSION=$1

if [ -z "$1" ]; then
  echo "Please specify a version, ex: 0.10.17"
  exit 1
fi

echo "Initializing node.git / official node.js repo"
git submodule init

echo "Updating node.git"
git submodule update

pushd node.git
  echo "Creating tar archive of node.git v${VERSION}"
  git archive --format=tar -o ../nodejs_${VERSION}.orig.tar --prefix=nodejs-${VERSION}/ v${VERSION}
popd

echo "Extracting node.js archive"
tar xf nodejs_${VERSION}.orig.tar
gzip nodejs_${VERSION}.orig.tar

cp -r debian nodejs-${VERSION}

echo "Fetching changelog for v${VERSION}"
git show ${VERSION}:debian/changelog > nodejs-${VERSION}/debian/changelog

echo "Building node.js .deb package"
cd nodejs-${VERSION}
debuild -j4 -us -uc

exit 0