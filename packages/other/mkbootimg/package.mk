# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="mkbootimg"
PKG_VERSION="6668fc24a3"
PKG_SITE="https://github.com/codesnake/mkbootimg/tree/master"
PKG_URL="https://github.com/codesnake/mkbootimg/archive/$PKG_VERSION.tar.gz"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
  cp mkbootimg $TOOLCHAIN/bin
}
