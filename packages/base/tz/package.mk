# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="tz"
PKG_VERSION="2019c"
PKG_SITE="https://www.iana.org/time-zones"
PKG_WATCH="https://github.com/eggert/tz/releases/ .*/archive/(.*)\.tar\.gz"
PKG_URL="https://github.com/eggert/tz/archive/$PKG_VERSION.tar.gz"

PKG_MAKE_OPTS_TARGET="CC=$HOST_CC LDFLAGS="

makeinstall_target() {
  make TZDIR="$INSTALL/usr/share/zoneinfo" REDO=posix_only TOPDIR="$INSTALL" install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/sbin
  rm -rf $INSTALL/etc
  mkdir -p $INSTALL/etc
  ln -sf /storage/.config/localtime $INSTALL/etc/localtime
}
