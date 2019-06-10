# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="Python"
PKG_VERSION="3.8.0"
PKG_SITE="http://www.python.org/"
#PKG_WATCH="https://www.python.org/downloads/ .*/ftp/python/[\d\.]*/Python-([\d\.]*).tar.xz"
PKG_URL="http://www.python.org/ftp/python/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="libffi:host"
PKG_DEPENDS_TARGET="sqlite expat libffi libressl Python:host"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="
  ac_cv_prog_HAS_HG=/bin/false
  ac_cv_prog_SVNVERSION=/bin/false
  --disable-pyc-build
  --disable-ossaudiodev
  --disable-sqlite3
  --disable-codecs-cjk
  --disable-nis
  --enable-unicodedata
  --disable-openssl
  --disable-readline
  --disable-bzip2
  --enable-zlib
  --disable-xz
  --disable-tk
  --disable-curses
  --disable-pydoc
  --disable-test-modules
  --disable-lib2to3
  --disable-idle3
  --without-cxx-main
  --with-expat=builtin
  --with-libmpdec=none
  --with-doc-strings
  --without-pymalloc
  --without-ensurepip
"

PKG_CONFIGURE_OPTS_TARGET="
  ac_cv_have_long_long_format=yes
  ac_cv_file__dev_ptmx=no
  ac_cv_file__dev_ptc=no
  ac_cv_working_tzset=yes
  ac_cv_prog_HAS_HG=/bin/false
  ac_cv_prog_SVNVERSION=/bin/false
  ac_cv_file_dev_ptc=no
  ac_cv_file_dev_ptmx=yes
  ac_cv_func_lchflags_works=no
  ac_cv_func_chflags_works=no
  ac_cv_func_printf_zd=yes
  ac_cv_buggy_getaddrinfo=no
  ac_cv_header_bluetooth_bluetooth_h=no
  ac_cv_header_bluetooth_h=no
  --disable-pyc-build
  --disable-ossaudiodev
  --enable-sqlite3
  --disable-codecs-cjk
  --disable-nis
  --enable-unicodedata
  --enable-openssl
  --disable-readline
  --disable-bzip2
  --enable-zlib
  --disable-xz
  --disable-tk
  --disable-curses
  --disable-pydoc
  --disable-test-modules
  --disable-lib2to3
  --disable-idle3
  --without-cxx-main
  --with-expat=system
  --with-libmpdec=none
  --with-doc-strings
  --without-pymalloc
  --without-ensurepip
"

post_unpack() {
  # This is needed to make sure the Python build process doesn't try to
  # regenerate those files with the pgen program. Otherwise, it builds
  # pgen for the target, and tries to run it on the host.
  touch $PKG_BUILD/Include/graminit.h
  touch $PKG_BUILD/Python/graminit.c
}

post_makeinstall_host() {
  rm -f $TOOLCHAIN/bin/python*-config
  rm -f $TOOLCHAIN/bin/smtpd.py*
  rm -f $TOOLCHAIN/bin/2to3*
  rm -f $TOOLCHAIN/bin/pyvenv
  rm -f $TOOLCHAIN/bin/pydoc*
}

post_makeinstall_target() {
  EXCLUDE_DIR="ensurepip config compiler distutils sysconfigdata unittest"
  for dir in $EXCLUDE_DIR; do
    rm -rf $INSTALL/usr/lib/python3.8/$dir
  done
  rm -rf $INSTALL/usr/lib/python3.8/lib-dynload/sysconfigdata

  rm -f $INSTALL/usr/bin/python*-config
  rm -f $INSTALL/usr/bin/smtpd.py*
  rm -f $INSTALL/usr/bin/2to3*
  rm -f $INSTALL/usr/bin/pyvenv
  rm -f $INSTALL/usr/bin/pydoc*

  cd $INSTALL/usr/lib/python3.8
  $TOOLCHAIN/bin/python3 -Wi -t -B $PKG_BUILD/Lib/compileall.py -d /usr/lib/python3.8 -b -f .
  find $INSTALL/usr/lib/python3.8 -name "*.py" -exec rm -f {} \; &>/dev/null

  # meh. for ext modules: export _PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata_build
  cp -a $SYSROOT_PREFIX/usr/lib/python3.8/_sysconfigdata*.py $TOOLCHAIN/lib/python3.8/_sysconfigdata_build.py
}
