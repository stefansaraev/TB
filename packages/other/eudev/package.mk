# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="eudev"
PKG_VERSION="3.2.9"
PKG_SITE="https://github.com/gentoo/eudev"
PKG_WATCH="https://github.com/gentoo/eudev/releases/ .*/archive/v([\d\.]*)\.tar\.gz"
PKG_URL="https://github.com/gentoo/eudev/archive/v$PKG_VERSION.tar.gz"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="
  --disable-shared --enable-static
  --enable-introspection=no
  --disable-blkid
  --disable-selinux
  --disable-manpages
  --disable-kmod
  --disable-hwdb
  --disable-rule-generator
  --disable-mtd_probe
"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
}

post_makeinstall_target() {
  # static linking is fucked up. page_size() is also used in alsa-lib
  $OBJCOPY --redefine-sym page_size=udev_page_size $SYSROOT_PREFIX/usr/lib/libudev.a

  rm -rf $INSTALL/etc/udev/hwdb.d
  rm -rf $INSTALL/usr/lib/udev/collect
  rm -rf $INSTALL/usr/lib/udev/*_id
  rm -rf $INSTALL/usr/lib/udev/rules.d

  mkdir -p $INSTALL/usr/lib/udev/rules.d
  cp $PKG_DIR/rules/*.rules $INSTALL/usr/lib/udev/rules.d
}
