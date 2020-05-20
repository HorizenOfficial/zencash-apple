#!/bin/sh

# get version info
git_rev_output=$(git rev-parse --verify HEAD)
git_tag_output=$(git describe --all --exact-match $git_rev_output)
git_status_output=$(git diff)

# check if associated tag exist for that commit
if [[ $git_tag_output == *"tags"* ]]; then
   git_tag_string=${git_tag_output##*/}
else
   git_tag_string="unknown"
fi

# check for any code modifications
if [ -n "$git_status_output" ]; then
   git_rev_string=$git_rev_output-dirty
   git_tag_string="unknown"
else
   git_rev_string=$git_rev_output
fi

# pick version string (tag name, if exists or commit version)
if [[ $git_tag_string == "unknown" ]]; then
   release_version=$git_rev_string
else
   release_version=$git_tag_string
fi

echo "zen-for-macos commit version : $git_rev_string"
echo "zen-for-macos tag version    : $git_tag_string"
echo "creating 'zen-macos-$release_version' release"

# prepare environment
source environment;
export BSPJOB=16;
export BSPINSTALL=${BSPROOT}/zen-macos-$release_version;

# build tools
make
echo $git_rev_string  > ${BSPINSTALL}/usr/local/bin/version.txt
echo $git_tag_string >> ${BSPINSTALL}/usr/local/bin/version.txt
echo "Zen for macOS ($release_version) is installed to ${BSPINSTALL}"

# create tarball and checksum
echo "creating Zen tarball 'zen-macos-$release_version.tar.bz2' and checksum"
tar -cjvf zen-macos-$release_version.tar.bz2 zen-macos-$release_version
shasum -a 256 zen-macos-$release_version.tar.bz2 > zen-macos-$release_version.tar.bz2.hash
shasum -a 256 -c zen-macos-$release_version.tar.bz2.hash
