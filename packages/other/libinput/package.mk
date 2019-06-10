# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libinput"
PKG_VERSION="1.15.1"
PKG_SITE="https://www.freedesktop.org/wiki/Software/libinput/"
PKG_WATCH="http://www.freedesktop.org/software/libinput/ libinput-(.*)\.tar\.xz"
PKG_URL="https://www.freedesktop.org/software/libinput/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="mtdev libevdev"

PKG_MESON_OPTS_TARGET="
  -Dlibwacom=false
  -Ddebug-gui=false
  -Dtests=false
  -Ddocumentation=false
"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/libexec
  rm -rf $INSTALL/usr/lib/udev
  rm -rf $INSTALL/usr/lib/libinput
  rm -rf $INSTALL/usr/share/libinput
}
