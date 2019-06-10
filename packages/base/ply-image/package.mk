# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="ply-image"
PKG_VERSION="2a91b27109"
PKG_SITE="https://github.com/stefansaraev/ply-image/tree/master"
PKG_URL="https://github.com/stefansaraev/ply-image/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_INIT="libpng"

makeinstall_init() {
  mkdir -p $INSTALL/bin
  cp ply-image $INSTALL/bin

  mkdir -p $INSTALL/splash
  cp $ROOT/config/splash/* $INSTALL/splash
}
