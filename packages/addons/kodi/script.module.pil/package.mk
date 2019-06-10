# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="script.module.pil"
PKG_VERSION="1.1.7.3"
PKG_DEPENDS_TARGET="Pillow"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/lib
  cp -R $PKG_DIR/files/* $INSTALL
  cp -R $(get_pkg_build Pillow)/.install_target/usr/lib/python3.8/site-packages/PIL $INSTALL/lib
  sed -e "s|@VERSION@|$PKG_VERSION|g" -i $INSTALL/addon.xml
}

addon() {
  mkdir -p $ADDON_INSTALL
  cp -R $INSTALL/* $ADDON_INSTALL
}
