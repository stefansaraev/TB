# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libjpeg-turbo"
PKG_VERSION="2.0.3"
PKG_SITE="https://libjpeg-turbo.org/"
#PKG_WATCH="https://github.com/libjpeg-turbo/libjpeg-turbo/releases .*/archive/(.*)\.tar\.gz"
PKG_URL="https://github.com/libjpeg-turbo/libjpeg-turbo/archive/$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_TARGET="
  -DENABLE_STATIC=ON
  -DENABLE_SHARED=OFF
  -DWITH_SIMD=ON
  -DWITH_JPEG8=ON
"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
