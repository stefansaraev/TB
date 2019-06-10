# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="keytable"
PKG_VERSION="950397fb85"
PKG_SITE="https://github.com/stefansaraev/keytable/tree/master"
PKG_URL="https://github.com/stefansaraev/keytable/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="libuargp"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD/keytable $INSTALL/usr/bin
}
