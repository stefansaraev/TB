# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="visualization.spectrum"
PKG_VERSION="9bfc1c6926"
PKG_SITE="https://github.com/xbmc/visualization.spectrum/tree/master"
PKG_URL="https://github.com/xbmc/visualization.spectrum/archive/$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_TARGET="
  -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/share/kodi/cmake
  -DKODI_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include/kodi
"

addon() {
  mkdir -p $ADDON_INSTALL
  cp -R $INSTALL/usr/share/kodi/addons/$PKG_NAME/* $ADDON_INSTALL
  cp -L $INSTALL/usr/lib/kodi/addons/$PKG_NAME/*.so $ADDON_INSTALL
}
