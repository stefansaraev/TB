# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="base"
PKG_DEPENDS_TARGET="
  toolchain musl linux busybox nano netbase dropbear tz
  opkg
  $ADDITIONAL_PACKAGES
"
