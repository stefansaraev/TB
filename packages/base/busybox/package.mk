# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="busybox"
PKG_VERSION="1.31.1"
PKG_SITE="http://www.busybox.net"
PKG_WATCH="https://busybox.net/downloads/ busybox-([\d\.]*)\.tar\.bz2"
PKG_URL="http://busybox.net/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_NEED_REBUILD="linux"

PKG_MAKE_OPTS_TARGET="
  ARCH=$TARGET_ARCH
  CROSS_COMPILE=${TARGET_NAME}-
  KBUILD_VERBOSE=0
  CONFIG_PREFIX=$INSTALL/usr
  install
"

PKG_MAKE_OPTS_INIT="
  ARCH=$TARGET_ARCH
  CROSS_COMPILE=${TARGET_NAME}-
  KBUILD_VERBOSE=0
  CONFIG_PREFIX=$INSTALL
  install
"

pre_configure_target() {
  mkdir -p $PKG_BUILD_SUBDIR
  cp $PKG_DIR/config/busybox-target.conf $PKG_BUILD_SUBDIR/.config
}

configure_target() {
  make O=$(pwd) -C ../ oldconfig
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
  ln -sf /tmp/resolv.conf $INSTALL/etc/resolv.conf
  ln -sf /storage/.config/hostname $INSTALL/etc/hostname
}

pre_configure_init() {
  mkdir -p $PKG_BUILD_SUBDIR
  cp $PKG_DIR/config/busybox-init.conf $PKG_BUILD_SUBDIR/.config
}

configure_init() {
  make O=$(pwd) -C ../ oldconfig
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
  ln -sf busybox $INSTALL/bin/sh
}
