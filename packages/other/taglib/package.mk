# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="taglib"
PKG_VERSION="1.11.1"
PKG_SITE="http://taglib.github.com/"
PKG_WATCH="https://github.com/taglib/taglib/releases/ .*/archive/v([\d\.]*)\.tar\.gz"
PKG_URL="http://taglib.github.io/releases/$PKG_NAME-$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
