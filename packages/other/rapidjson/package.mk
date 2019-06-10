# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="rapidjson"
PKG_VERSION="1.1.0"
PKG_SITE="https://github.com/miloyip/rapidjson"
PKG_WATCH="https://github.com/miloyip/rapidjson/releases/ .*/archive/v([\d\.]*)\.tar\.gz"
PKG_URL="https://github.com/miloyip/rapidjson/archive/v$PKG_VERSION.tar.gz"

PKG_CMAKE_OPTS_TARGET="
  -DRAPIDJSON_BUILD_DOC=OFF
  -DRAPIDJSON_BUILD_EXAMPLES=OFF
  -DRAPIDJSON_BUILD_TESTS=OFF
  -DRAPIDJSON_BUILD_THIRDPARTY_GTEST=OFF
  -DRAPIDJSON_BUILD_ASAN=OFF
  -DRAPIDJSON_BUILD_UBSAN=OFF
  -DRAPIDJSON_HAS_STDSTRING=ON
"
