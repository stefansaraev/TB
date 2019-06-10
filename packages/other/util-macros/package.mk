# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="util-macros"
PKG_VERSION="1.19.2"
PKG_SITE="http://www.X.org"
PKG_WATCH="http://xorg.freedesktop.org/archive/individual/util/ util-macros-([\d\.]*)\.tar\.bz2"
PKG_URL="http://xorg.freedesktop.org/archive/individual/util/$PKG_NAME-$PKG_VERSION.tar.bz2"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
