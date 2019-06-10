# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="mtdev"
PKG_VERSION="1.1.6"
PKG_SITE="http://bitmath.org/code/mtdev/"
PKG_WATCH="http://bitmath.org/code/mtdev/ mtdev-([0-9.]+)\.tar\.gz"
PKG_URL="http://bitmath.org/code/mtdev/$PKG_NAME-$PKG_VERSION.tar.gz"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
