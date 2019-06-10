# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libpng"
PKG_VERSION="1.6.37"
PKG_SITE="https://github.com/glennrp/libpng"
PKG_WATCH="https://github.com/glennrp/libpng/releases .*/archive/v([\d\.]*)\.tar\.gz"
PKG_URL="https://github.com/glennrp/libpng/archive/v$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_TARGET="-DPNG_SHARED=OFF -DPNG_STATIC=ON"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
  rm -rf $SYSROOT_PREFIX/usr/bin/libpng*-config
}
