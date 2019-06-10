# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="p8-platform"
PKG_VERSION="1eb12b1b1e"
PKG_SITE="https://github.com/Pulse-Eight/platform/tree/master"
PKG_URL="https://github.com/Pulse-Eight/platform/archive/$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
