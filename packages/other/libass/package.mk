# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libass"
PKG_VERSION="0.14.0"
PKG_SITE="https://github.com/libass/libass"
PKG_WATCH="https://github.com/libass/libass/releases/ .*/archive/([\d\.]*)\.tar\.gz"
PKG_URL="https://github.com/libass/libass/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="freetype fribidi"

PKG_CONFIGURE_OPTS_TARGET="
  --disable-shared --enable-static
  --disable-test
  --disable-fontconfig
  --disable-require-system-font-provider
  --disable-harfbuzz
"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
