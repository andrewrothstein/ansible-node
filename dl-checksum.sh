#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=http://nodejs.org/dist

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=$5
    local platform=${os}-${arch}
    local file=node-v${ver}-${platform}.${archive_type}
    local url=$MIRROR/v${ver}/$file

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `fgrep $file $lchecksums | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    local lchecksums=$DIR/node_${ver}_SHASUMS256.txt
    local rchecksums=$MIRROR/v${ver}/SHASUMS256.txt

    if [ ! -e $lchecksums ];
    then
        wget -q -O $lchecksums $rchecksums
    fi


    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver
    dl $ver $lchecksums aix ppc64 tar.gz
    dl $ver $lchecksums darwin x64 tar.gz
    dl $ver $lchecksums linux arm64 tar.gz
    dl $ver $lchecksums linux armv7l tar.gz
    dl $ver $lchecksums linux ppc64le tar.gz
    dl $ver $lchecksums linux s390x tar.gz
    dl $ver $lchecksums linux x64 tar.gz
    dl $ver $lchecksums win x64 zip
    dl $ver $lchecksums win x86 zip
}

dl_ver ${1:-15.8.0}
