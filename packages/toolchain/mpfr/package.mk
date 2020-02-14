# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="mpfr"
PKG_VERSION="4.0.2"
PKG_SITE="http://www.mpfr.org/"
PKG_WATCH="http://ftp.gnu.org/gnu/mpfr/ mpfr-([\d\.]*)\.tar\.xz"
PKG_URL="http://ftp.gnu.org/gnu/mpfr/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="gmp:host"

PKG_CONFIGURE_OPTS_HOST="
  --disable-shared --enable-static --with-pic
  --target=$TARGET_NAME
"
