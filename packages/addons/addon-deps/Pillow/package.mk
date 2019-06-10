# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="Pillow"
PKG_VERSION="6.2.1"
PKG_SITE="https://github.com/python-pillow/Pillow"
#PKG_WATCH="https://github.com/python-pillow/Pillow/releases .*/archive/(.*)\.tar\.gz"
PKG_URL="https://github.com/python-pillow/Pillow/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="Python setuptools:host libjpeg-turbo freetype"

pre_configure_target() {
  export LIBRARY_PATH="$SYSROOT_PREFIX/usr/lib"
  export C_INCLUDE_PATH="$SYSROOT_PREFIX/usr/include"
  export LDSHARED="$CC -shared"
  export _PYTHON_SYSCONFIGDATA_NAME="_sysconfigdata_build"
}

make_target() {
  python3 setup.py build_ext \
    --disable-platform-guessing \
    --disable-tiff \
    --disable-freetype \
    --disable-lcms \
    --disable-webp \
    --disable-webpmux \
    --disable-jpeg2000 \
    --disable-imagequant
}

makeinstall_target() {
  python3 setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  cd $INSTALL/usr/lib/python3.8
  $TOOLCHAIN/bin/python3 -Wi -t -B $(get_pkg_build Python)/Lib/compileall.py -d /usr/lib/python3.8 -b -f .
  find $INSTALL/usr/lib/python3.8 -name "*.py" -exec rm -f {} \; &>/dev/null
  rm -rf $INSTALL/usr/lib/python3.8/site-packages/PIL/__pycache__
}
