# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="mpc"
PKG_VERSION="1.1.0"
PKG_SITE="http://www.multiprecision.org"
PKG_WATCH="http://ftp.gnu.org/gnu/mpc/ mpc-([\d\.]*)\.tar\.gz"
PKG_URL="http://ftp.gnu.org/gnu/mpc/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="gmp:host mpfr:host"

PKG_CONFIGURE_OPTS_HOST="
  --disable-shared --enable-static --with-pic
  --target=$TARGET_NAME
"