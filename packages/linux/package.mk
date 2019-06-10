# SPDX-License-Identifier: GPL-2.0-only

PKG_NAME="linux"
PKG_VERSION="5.5.3"
PKG_SITE="http://www.kernel.org"
PKG_WATCH="https://www.kernel.org/pub/linux/kernel/v5.x/ linux-([\d\.]*)\.tar\.gz"
PKG_URL="https://www.kernel.org/pub/linux/kernel/v5.x/$PKG_NAME-$PKG_VERSION.tar.gz"
#PKG_WATCH="https://www.kernel.org/ https://git.kernel.org/torvalds/t/linux-(.*)\.tar\.gz"
#PKG_URL="https://git.kernel.org/torvalds/t/linux-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain $KERNEL_EXTRA_DEPENDS"
PKG_NEED_REBUILD="busybox"

post_unpack() {
  cp $PROJECT_DIR/packages/linux/linux.$TARGET_ARCH.conf $PKG_BUILD/.config

  sed -e "s|^ARCH[[:space:]]*?=.*$|ARCH = $TARGET_KERNEL_ARCH|" \
      -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = ${TARGET_NAME}-|" \
      -i $PKG_BUILD/Makefile
}

make_host() {
  :
}

makeinstall_host() {
  make INSTALL_HDR_PATH=$SYSROOT_PREFIX/usr headers_install
}

pre_configure_target() {
  make -C $PKG_BUILD oldconfig
  export KBUILD_BUILD_USER="-,-'<"
  export KBUILD_BUILD_HOST=","
}

make_target() {
  ( cd $ROOT
    rm -rf $BUILD/image/init
    scripts/install initramfs
  )
  make CROSS_COMPILE=${TARGET_NAME}- LDFLAGS="" $KERNEL_TARGET $KERNEL_EXTRA_TARGET
}

makeinstall_target() {
  DTB_BLOBS=$(ls arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/*.dtb 2>/dev/null || :)
  DTB_BLOB_OUTPUT="arch/$TARGET_KERNEL_ARCH/boot/dtb.img"
  KERNEL_BOOTIMG_SECOND="--second $DTB_BLOB_OUTPUT"

  $TOOLCHAIN/bin/dtbTool -o $DTB_BLOB_OUTPUT -p scripts/dtc/ arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/

  mkbootimg --kernel arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET \
            --output arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET \
            --ramdisk $BUILD/image/init.cpio \
            $KERNEL_BOOTIMG_SECOND $KERNEL_BOOTIMG_OPTIONS
}

post_makeinstall_target() {
  rm -f $INSTALL/lib/modules/*/build
  rm -f $INSTALL/lib/modules/*/source
}
