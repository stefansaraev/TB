# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="tinyxml"
PKG_VERSION="2.6.2_2"
PKG_SITE="http://www.grinninglizard.com/tinyxml/"
PKG_URL="http://mirrors.xbmc.org/build-deps/sources/$PKG_NAME-$PKG_VERSION.tar.gz"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
