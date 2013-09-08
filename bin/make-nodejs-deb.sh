#!/bin/bash
#
# Script to automate the build of a Node.JS debian package
#
# Copyright (c) 2013 Alex Williams, Unscramble <license@unscramble.jp>
#
# License: MIT

set -x

VERSION=$1

git submodule init
git submodule update
pushd node.git
  git archive --format=tar -o ../nodejs_${VERSION}.orig.tar --prefix=nodejs-${VERSION}/ v${VERSION}
popd

tar xf nodejs_${VERSION}.orig.tar
gzip nodejs_${VERSION}.orig.tar
cp -r debian nodejs-${VERSION}
cd nodejs-${VERSION}
debuild -j4 -us -uc
