# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="ffmpeg"
PKG_VERSION="4.1.4"
PKG_SITE="https://ffmpeg.org"
PKG_URL="http://ffmpeg.org/releases/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_WATCH="https://ffmpeg.org/releases/ ffmpeg-([0-9.]+)\.tar\.xz"
PKG_DEPENDS_TARGET="libressl libdrm"

CONFIGURE_OPTS_TARGET="
  --disable-shared --enable-static --enable-pic
  --prefix=/usr
  --arch=$TARGET_ARCH
  --cpu=$TARGET_CPU
  --cross-prefix=${TARGET_NAME}-
  --enable-cross-compile
  --sysroot=$SYSROOT_PREFIX
  --sysinclude=$SYSROOT_PREFIX/usr/include
  --target-os=linux
  --pkg-config=/usr/bin/pkg-config
  --disable-logging
  --enable-gpl
  --enable-nonfree
  --disable-runtime-cpudetect
  --disable-programs
  --disable-doc
  --disable-avdevice
  --disable-vaapi
  --disable-vdpau
  --disable-encoders
  --enable-encoder=aac,ac3,mjpeg,png
  --disable-muxers
  --enable-muxer=adts,spdif
  --disable-indevs
  --disable-outdevs
  --disable-devices
  --disable-alsa
  --disable-bzlib
  --disable-iconv
  --disable-openssl
  --enable-libtls
  --disable-sdl2
  --disable-xlib
  --disable-symver
  --disable-altivec
  --disable-debug
  --disable-extra-warnings
  --enable-v4l2_m2m --enable-libdrm
"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/ffmpeg/examples
}
