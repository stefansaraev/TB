# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="xkeyboard-config"
PKG_VERSION="2.29"
PKG_SITE="http://www.X.org"
PKG_WATCH="https://xorg.freedesktop.org/releases/individual/data/xkeyboard-config/ xkeyboard-config-(.*)\.tar\.gz"
PKG_URL="http://www.x.org/releases/individual/data/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="util-macros"

PKG_CONFIGURE_OPTS_TARGET="
  --without-xsltproc
  --disable-compat-rules
  --disable-runtime-deps
  --disable-nls
  --disable-rpath
"
