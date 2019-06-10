# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="pvr.hts"
PKG_VERSION="56e95c4b33"
PKG_SITE="https://github.com/kodi-pvr/pvr.hts/tree/Matrix"
PKG_URL="https://github.com/kodi-pvr/pvr.hts/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="p8-platform"

PKG_CMAKE_OPTS_TARGET="
  -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/share/kodi/cmake
  -DKODI_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include/kodi
"

addon() {
  mkdir -p $ADDON_INSTALL
  cp -R $INSTALL/usr/share/kodi/addons/$PKG_NAME/* $ADDON_INSTALL
  cp -L $INSTALL/usr/lib/kodi/addons/$PKG_NAME/*.so $ADDON_INSTALL
}
