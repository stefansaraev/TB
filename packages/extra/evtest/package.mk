# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="evtest"
PKG_VERSION="1.34"
PKG_SITE="http://cgit.freedesktop.org/evtest/"
PKG_WATCH="https://cgit.freedesktop.org/evtest/ .*/?h=evtest-(.*)"
PKG_URL="http://cgit.freedesktop.org/evtest/snapshot/$PKG_NAME-$PKG_VERSION.tar.bz2"

PKG_AUTORECONF="yes"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -static"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/evtest $INSTALL/usr/bin
}
