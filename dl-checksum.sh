#!/usr/bin/env sh
VER=${1:-12.11.1}
DIR=~/Downloads
MIRROR=http://nodejs.org/dist/v${VER}

LCHECKSUMS=$DIR/node_${VER}_SHASUMS256.txt
RCHECKSUMS=$MIRROR/SHASUMS256.txt

if [ ! -e $LCHECKSUMS ];
then
    wget -q -O $LCHECKSUMS $RCHECKSUMS
fi


dl()
{
    local os=$1
    local arch=$2
    local archive_type=$3
    local platform=${os}-${arch}
    local file=node-v${VER}-${platform}.${archive_type}
    local url=$MIRROR/$file

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `fgrep $file $LCHECKSUMS | awk '{print $1}'`
}

printf "  # %s\n" $RCHECKSUMS
printf "  '%s':\n" $VER
dl aix ppc64 tar.gz
dl darwin x64 tar.gz
dl linux arm64 tar.gz
dl linux armv7l tar.gz
dl linux ppc64le tar.gz
dl linux s390x tar.gz
dl linux x64 tar.gz
dl sunos x64 tar.gz
dl win x64 zip
dl win x86 zip
