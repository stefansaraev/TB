# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="skin.tb"
PKG_VERSION="7950dce007"
PKG_SITE="https://github.com/stefansaraev/skin.tb/tree/master"
PKG_URL="https://github.com/stefansaraev/skin.tb/archive/$PKG_VERSION.tar.gz"

make_target() {
  :
}

makeinstall_target() {
  SKINDIR="$INSTALL/usr/share/kodi/addons/skin.tb"
  mkdir -p $SKINDIR
  cp -PR $PKG_BUILD/* $SKINDIR
}

post_makeinstall_target() {
  # remove languages
  find $INSTALL/usr/share/kodi/addons -name strings.po | grep -v "resource.language.en_gb" | xargs rm -f {} \;
}
