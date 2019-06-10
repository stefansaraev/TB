# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libxkbcommon"
PKG_VERSION="0.10.0"
PKG_SITE="https://www.xkbcommon.org/"
PKG_WATCH="http://xkbcommon.org/download/ libxkbcommon-(.*)\.tar\.xz"
PKG_URL="https://xkbcommon.org/download/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="xkeyboard-config"

PKG_MESON_OPTS_TARGET="
  -Ddefault_library=static
  -Denable-docs=false
  -Denable-x11=false
  -Denable-wayland=false
"
