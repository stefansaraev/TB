# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="freetype"
PKG_VERSION="2.10.0"
PKG_SITE="http://www.freetype.org"
PKG_WATCH="http://download.savannah.gnu.org/releases/freetype/ freetype-([\d\.]*)\.tar\.bz2"
PKG_URL="http://download.savannah.gnu.org/releases/freetype/$PKG_NAME-$PKG_VERSION.tar.bz2"

PKG_CONFIGURE_OPTS_TARGET="
  --disable-shared --enable-static
  --with-zlib
  --with-bzip2=no
  --with-png=no
  --with-harfbuzz=no
"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
}

post_unpack() {
  rm -f $PKG_BUILD/CMakeLists.txt
}

post_makeinstall_target() {
  rm -f $SYSROOT_PREFIX/usr/bin/freetype-config
  rm -rf $INSTALL/usr/bin
}
