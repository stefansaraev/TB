# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libevdev"
PKG_VERSION="1.8.0"
PKG_SITE="https://www.freedesktop.org/wiki/Software/libevdev/"
PKG_WATCH="https://www.freedesktop.org/software/libevdev/ libevdev-([\d\.]*)\.tar\.xz"
PKG_URL="https://www.freedesktop.org/software/libevdev/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="eudev"

PKG_CONFIGURE_OPTS_TARGET="
  --disable-shared --enable-static
  --disable-test-run
  --disable-gcov
"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
