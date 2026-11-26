#!/usr/bin/env sh
set -e
DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT
MIRROR=https://nodejs.org/dist

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

    local sum
    sum=$(awk -v f="$file" '$2 == f || $2 == "*" f {print $1}' "$lchecksums")
    if ! printf '%s' "$sum" | grep -Eq '^[0-9a-f]{64}$'
    then
        echo "bad or missing checksum for $file: '$sum'" >&2
        exit 1
    fi
    printf "    # %s\n" "$url"
    printf "    %s: sha256:%s\n" "$platform" "$sum"
}

dl_ver() {
    local ver=$1
    local lchecksums=$DIR/node_${ver}_SHASUMS256.txt
    local rchecksums=$MIRROR/v${ver}/SHASUMS256.txt

    curl -fsSL --proto '=https' --tlsv1.2 -o "$lchecksums" "$rchecksums"


    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver
    dl $ver $lchecksums aix ppc64 tar.gz
    dl $ver $lchecksums darwin x64 tar.gz
    dl $ver $lchecksums darwin arm64 tar.gz
    dl $ver $lchecksums linux arm64 tar.gz
    dl $ver $lchecksums linux ppc64le tar.gz
    dl $ver $lchecksums linux s390x tar.gz
    dl $ver $lchecksums linux x64 tar.gz
    dl $ver $lchecksums win x64 zip
}

dl_ver ${1:-26.13.1}
