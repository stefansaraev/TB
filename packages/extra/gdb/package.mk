# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="gdb"
PKG_VERSION="9.1"
PKG_SITE="http://www.gnu.org/software/gdb/"
PKG_WATCH="http://ftp.gnu.org/gnu/gdb/ gdb-([\d\.]*)\.tar\.xz"
PKG_URL="http://ftp.gnu.org/gnu/gdb/$PKG_NAME-$PKG_VERSION.tar.xz"

PKG_CONFIGURE_OPTS_TARGET="
  bash_cv_have_mbstate_t=set
  --disable-shared --enable-static
  --with-auto-load-safe-path=/
  --datarootdir=/storage/.extra/usr/share/gdb/syscalls
  --enable-gdbcli
  --disable-gdbmi
  --disable-tui
  --disable-gdbtk
  --disable-profiling
  --disable-rpath
  --disable-libmcheck
  --disable-sim
  --disable-multi-ice
  --disable-gdbserver
  --without-curses
  --with-system-zlib
  --without-libiconv-prefix
  --without-expat
  --without-mpfr
  --without-python
  --without-guile
  --without-lzma
  --without-tcl
  --without-tk
  --without-x
  --without-babeltrace
"

pre_configure_target() {
  export CC_FOR_BUILD="$HOST_CC"
  export CFLAGS_FOR_BUILD="$HOST_CFLAGS"
  export LDFLAGS="$LDFLAGS -static"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/gdb/gdb $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/share/gdb
  cp -R $PKG_BUILD_SUBDIR/gdb/data-directory/syscalls $INSTALL/usr/share/gdb/syscalls
}
