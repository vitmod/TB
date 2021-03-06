################################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="linux"
PKG_VERSION="$KERNEL_VERSION"
PKG_SITE="http://www.kernel.org"
PKG_URL="$KERNEL_URL"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain kmod:host"
PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/linux/linux.$TARGET_ARCH.conf $ROOT/packages/linux/package.mk"
PKG_SHORTDESC="The Linux kernel"

PKG_MAKE_OPTS_HOST="ARCH=$TARGET_KERNEL_ARCH headers_check"

if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mkbootimg:host"
fi

post_unpack() {
  cp $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf $PKG_BUILD/.config

  if [ ! "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"$BUILD/image/init.cpio\"|" \
      $PKG_BUILD/.config
  fi
  sed -i -e "s|^HOSTCC[[:space:]]*=.*$|HOSTCC = $HOST_CC|" \
         -e "s|^HOSTCXX[[:space:]]*=.*$|HOSTCXX = $HOST_CXX|" \
         -e "s|^ARCH[[:space:]]*?=.*$|ARCH = $TARGET_KERNEL_ARCH|" \
         -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = $TARGET_PREFIX|" \
         $PKG_BUILD/Makefile
}

pre_build_target() {
  make -C $PKG_BUILD oldconfig
}

makeinstall_host() {
  make ARCH=$TARGET_KERNEL_ARCH INSTALL_HDR_PATH=dest headers_install
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp -R dest/include/* $SYSROOT_PREFIX/usr/include
}

make_target() {
  unset LDFLAGS

  make modules
  make INSTALL_MOD_PATH=$INSTALL INSTALL_MOD_STRIP=1 DEPMOD="$TOOLCHAIN/bin/depmod" \
    modules_install

  ( cd $ROOT
    rm -rf $BUILD/image/init
    scripts/install initramfs
  )

  for extra_target in "$KERNEL_EXTRA_TARGET"; do
    make $extra_target
  done
  make $KERNEL_TARGET

  if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    mkbootimg \
      --kernel arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET \
      --ramdisk $BUILD/image/init.cpio \
      --second "$ANDROID_BOOTIMG_SECOND" \
      --output arch/$TARGET_KERNEL_ARCH/boot/boot.img \
      $ANDROID_BOOTIMG_OPTIONS
    mv -f arch/$TARGET_KERNEL_ARCH/boot/boot.img arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET
  fi
}

makeinstall_target() {
  : # meh
}

post_makeinstall_target() {
  rm -f $INSTALL/lib/modules/*/build
  rm -f $INSTALL/lib/modules/*/source
}
