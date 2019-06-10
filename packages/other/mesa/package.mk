# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="mesa"
PKG_VERSION="19.3.3"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://mesa.freedesktop.org/archive/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_WATCH="https://www.mesa3d.org/ relnotes/([\d\.]*).html"
PKG_DEPENDS_TARGET="expat libdrm"

PKG_MESON_OPTS_TARGET="
  -Ddri-drivers=
  -Dgallium-drivers=kmsro,lima
  -Dgallium-extra-hud=false
  -Dgallium-xvmc=false
  -Dgallium-omx=disabled
  -Dgallium-nine=false
  -Dgallium-opencl=disabled
  -Dvulkan-drivers=
  -Dshader-cache=true
  -Dshared-glapi=true
  -Dopengl=true
  -Dgbm=true
  -Degl=true
  -Dglvnd=false
  -Dasm=false
  -Dvalgrind=false
  -Dlibunwind=false
  -Dlmsensors=false
  -Dbuild-tests=false
  -Dselinux=false
  -Dosmesa=none
  -Dplatforms=drm -Ddri3=false -Dglx=disabled
  -Dllvm=false
  -Dgallium-vdpau=false
  -Dgallium-va=false
  -Dgallium-xa=false
  -Dgles1=false -Dgles2=true
"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share
}
