# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="netbase"
PKG_VERSION="6.0"
PKG_SITE="http://packages.debian.org/netbase"
PKG_WATCH="http://ftp.debian.org/debian/pool/main/n/netbase/ netbase_(.*)\.tar\.xz"
PKG_URL="http://ftp.debian.org/debian/pool/main/n/netbase/${PKG_NAME}_${PKG_VERSION}.tar.xz"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
  cp etc/protocols $INSTALL/etc/protocols
  cp etc/services $INSTALL/etc/services
}
