# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="pcre"
PKG_VERSION="8.44"
PKG_SITE="http://www.pcre.org/"
PKG_WATCH="https://ftp.pcre.org/pub/pcre/ pcre-(.*)\.tar\.bz2"
PKG_URL="https://ftp.pcre.org/pub/pcre/$PKG_NAME-$PKG_VERSION.tar.bz2"

PKG_CMAKE_OPTS_TARGET="
  -DPCRE_BUILD_PCRE16=ON
  -DPCRE_SUPPORT_UTF=ON
  -DPCRE_SUPPORT_UNICODE_PROPERTIES=ON
"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
