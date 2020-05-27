#!/bin/bash

LOCALBIN=$HOME/bin
mkdir -p $LOCALBIN

fly_latest_api="https://api.github.com/repos/concourse/concourse/releases/latest"
fly_latest_url=$(curl --silent "$fly_latest_api" | \
 jq -r '.assets[] | select(.name |
 contains("fly") and contains("darwin-amd64.tgz") and (contains("sha1") | not) ) |
 .browser_download_url')

pushd $LOCALBIN
wget "$fly_latest_url" -O "${fly_latest_url##*/}"

for file in $(ls *.tgz); do
tar xzvf $file
done

rm -f *.tgz
chmod +x *

popd
