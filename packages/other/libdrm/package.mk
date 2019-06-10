# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="libdrm"
PKG_VERSION="2.4.100"
PKG_SITE="http://dri.freedesktop.org"
PKG_WATCH="http://dri.freedesktop.org/libdrm/ libdrm-([\d\.]*)\.tar\.bz2"
PKG_URL="http://dri.freedesktop.org/libdrm/$PKG_NAME-$PKG_VERSION.tar.bz2"

PKG_MESON_OPTS_TARGET="
  -Dlibkms=false
  -Dnouveau=false
  -Domap=false
  -Dexynos=false
  -Dtegra=false
  -Dintel=false
  -Dradeon=false
  -Damdgpu=false
  -Dvmwgfx=false
  -Dvc4=false
  -Dfreedreno=false
  -Detnaviv=false
  -Dcairo-tests=false
  -Dman-pages=false
  -Dvalgrind=false
  -Dfreedreno-kgsl=false
  -Dinstall-test-programs=false
  -Dudev=false
"

pre_configure_target() {
  rm -f $PKG_BUILD/configure
}
