# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="fstrcmp"
PKG_VERSION="0.7.D001"
PKG_SITE="http://fstrcmp.sourceforge.net/"
PKG_WATCH="http://fstrcmp.sourceforge.net/ fstrcmp-(.*)\.tar\.gz"
PKG_URL="http://fstrcmp.sourceforge.net/fstrcmp-$PKG_VERSION.tar.gz"

PKG_AUTORECONF="yes"

# broken beyond repair.
PKG_CONFIGURE_OPTS_TARGET="
  ac_cv_prog_LIBTOOL=$PKG_BUILD/libtool
  ac_cv_prog_GROFF=/bin/true
"

pre_configure_target() {
  # broken beyond repair.
  rm -rf $PKG_BUILD_SUBDIR
  export MAKEFLAGS=-j1
}

make_target() {
  :
}

makeinstall_target() {
  DESTDIR="$SYSROOT_PREFIX" make install-include install-libdir
}
