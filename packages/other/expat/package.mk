# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="expat"
PKG_VERSION="2.2.9"
PKG_SITE="http://expat.sourceforge.net/"
PKG_WATCH="https://github.com/libexpat/libexpat/releases/ .*/expat-(.*)\.tar\.bz2"
PKG_URL="http://prdownloads.sourceforge.net/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static --with-pic"

post_unpack() {
  rm -f $PKG_BUILD/CMakeLists.txt
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
