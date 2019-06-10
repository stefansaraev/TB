# SPDX-License-Identifier: GPL-2.0 Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="meson-firmware"
PKG_VERSION="89f739f891"
PKG_SITE="https://github.com/LibreELEC/meson-firmware/tree/master"
PKG_URL="https://github.com/LibreELEC/meson-firmware/archive/$PKG_VERSION.tar.gz"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/firmware
  cp -R meson $INSTALL/lib/firmware
}
