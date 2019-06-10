# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="initramfs"
PKG_DEPENDS_TARGET="toolchain busybox:init ply-image:init"

post_install() {
  ( cd $BUILD/image/init
    cp -PR $PROJECT_DIR/fs-init/* . 2>/dev/null || :
    fakeroot -- sh -c \
      "mkdir -p dev; mknod -m 600 dev/console c 5 1; find . | cpio -H newc -ov -R 0:0 > ../init.cpio"
  )
}
