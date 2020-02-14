# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="screen"
PKG_VERSION="4.8.0"
PKG_SITE="http://www.gnu.org/software/screen/"
PKG_WATCH="http://ftp.gnu.org/gnu/screen/ screen-([\d\.]*)\.tar\.gz"
PKG_URL="http://ftp.gnu.org/gnu/screen/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="netbsd-curses"

PKG_CONFIGURE_OPTS_TARGET="
  --enable-colors256
  --disable-pam
  --disable-use-locale
  --disable-telnet
  --disable-socket-dir
"

pre_configure_target() {
  # for color256 with netbsd-curses
  CFLAGS="$CFLAGS -DTERMINFO"
  export LDFLAGS="$LDFLAGS -static"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/screen $INSTALL/usr/bin/screen
}
