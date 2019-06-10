# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="flatbuffers"
PKG_VERSION="1.11.0"
PKG_SITE="https://github.com/google/flatbuffers"
PKG_WATCH="https://github.com/google/flatbuffers/releases/ .*/archive/v(.*)\.tar\.gz"
PKG_URL="https://github.com/google/flatbuffers/archive/v$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_HOST="
  -DFLATBUFFERS_BUILD_TESTS=OFF
  -DFLATBUFFERS_BUILD_FLATLIB=OFF
  -DFLATBUFFERS_BUILD_FLATC=ON
  -DFLATBUFFERS_BUILD_FLATHASH=OFF
"

PKG_CMAKE_OPTS_TARGET="
  -DFLATBUFFERS_BUILD_TESTS=OFF
  -DFLATBUFFERS_BUILD_FLATLIB=ON
  -DFLATBUFFERS_BUILD_FLATC=OFF
  -DFLATBUFFERS_BUILD_FLATHASH=OFF
"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
  cp $PKG_BUILD_SUBDIR/flatc $TOOLCHAIN/bin
}
