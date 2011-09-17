#!/usr/bin/env bash

function die() {
  echo $*
  exit 1
}

if [ $# -ne "1" ]
then
    die "$0: Received $# args... version required"
fi

VERSION=$1
./installerBuild.bash $VERSION "-Dsun.arch.data.model=32 -Pwindows" || die "Could not build?"

/Applications/install4j\ 5/bin/install4jc -m windows -r $VERSION ./install/lantern.install4j || die "Could not build installer"

name=lantern-$VERSION.exe
mv install/Lantern.exe $name
echo "Uploading to http://cdn.bravenewsoftware.org/$name..."
aws -putp lantern $name
echo "Uploaded lantern to http://cdn.bravenewsoftware.org/$name"
echo "Also available at http://lantern.s3.amazonaws.com/$name"
