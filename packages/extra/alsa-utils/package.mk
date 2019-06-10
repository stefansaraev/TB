# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="alsa-utils"
PKG_VERSION="1.2.1"
PKG_SITE="http://www.alsa-project.org/"
PKG_WATCH="ftp://ftp.alsa-project.org/pub/utils/ alsa-utils-([\d\.]*)\.tar\.bz2"
PKG_URL="ftp://ftp.alsa-project.org/pub/utils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="alsa-lib"

PKG_CONFIGURE_OPTS_TARGET="
  --disable-xmlto
  --disable-alsamixer
  --disable-alsaconf
  --disable-alsaloop
  --disable-alsatest
  --disable-bat
  --disable-nls
"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -static"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/alsactl/alsactl $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/amixer/amixer $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/aplay/aplay $INSTALL/usr/bin
  cp $PKG_BUILD_SUBDIR/speaker-test/speaker-test $INSTALL/usr/bin
}
