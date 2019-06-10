# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="kodi-send"
PKG_VERSION="96820704c8"
PKG_SITE="https://github.com/stefansaraev/kodi-send/tree/master"
PKG_URL="https://github.com/stefansaraev/kodi-send/archive/$PKG_VERSION.tar.gz"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -static"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/kodi-send $INSTALL/usr/bin
}
