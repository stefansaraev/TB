# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libffi"
PKG_VERSION="3.3"
PKG_SITE="http://sourceware.org/$PKG_NAME/"
PKG_WATCH="https://sourceware.org/pub/libffi/ libffi-([\d\.]*)\.tar\.gz"
PKG_URL="ftp://sourceware.org/pub/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"

PKG_CONFIGURE_OPTS_HOST="
  --disable-debug
  --enable-static --disable-shared
  --with-pic
  --enable-structs
  --enable-raw-api
  --disable-purify-safety
"

PKG_CONFIGURE_OPTS_TARGET="
  --disable-debug
  --enable-static --disable-shared
  --with-pic
  --enable-structs
  --enable-raw-api
  --disable-purify-safety
"
