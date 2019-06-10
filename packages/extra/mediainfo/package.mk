# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="mediainfo"
PKG_VERSION="19.09"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_WATCH="https://mediaarea.net/en/MediaInfo/Download/Source .*/MediaInfo_CLI_(.*)_GNU_FromSource\.tar\.gz"
PKG_URL="https://mediaarea.net/download/binary/mediainfo/${PKG_VERSION}/MediaInfo_CLI_${PKG_VERSION}_GNU_FromSource.tar.gz"

make_target() {
  ./CLI_Compile.sh \
    --host=$TARGET_NAME \
    --build=$HOST_NAME \
    --prefix=/usr
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD/MediaInfo/Project/GNU/CLI/mediainfo $INSTALL/usr/bin
}
