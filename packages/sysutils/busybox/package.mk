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

PKG_NAME="busybox"
PKG_VERSION="1.24.2"
PKG_SITE="http://www.busybox.net"
PKG_URL="http://busybox.net/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain"
PKG_SHORTDESC="BusyBox: The Swiss Army Knife of Embedded Linux"

PKG_MAKE_OPTS_TARGET="ARCH=$TARGET_ARCH \
                      HOSTCC=$HOST_CC \
                      CROSS_COMPILE=$TARGET_PREFIX \
                      KBUILD_VERBOSE=0 \
                      install"

PKG_MAKE_OPTS_INIT="ARCH=$TARGET_ARCH \
                    HOSTCC=$HOST_CC \
                    CROSS_COMPILE=$TARGET_PREFIX \
                    KBUILD_VERBOSE=0 \
                    install"

configure_init() {
  mkdir -p $PKG_BUILD_SUBDIR && cd $_
  cp $PKG_DIR/config/busybox-init.conf .config
  sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$INSTALL\"|" .config
  make O=`pwd` -C ../ oldconfig
}

configure_target() {
  mkdir -p $PKG_BUILD_SUBDIR && cd $_
  cp $PKG_DIR/config/busybox-target.conf .config
  sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$INSTALL\"|" .config
  make O=`pwd` -C ../ oldconfig
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
  ln -sf busybox $INSTALL/bin/sh

  mkdir -p $INSTALL/etc
  touch $INSTALL/etc/fstab
  ln -sf /proc/self/mounts $INSTALL/etc/mtab

  cp $PKG_DIR/config/functions $INSTALL
  cp $PKG_DIR/scripts/init $INSTALL
  chmod 755 $INSTALL/init

  if [ -f $PROJECT_DIR/$PROJECT/initramfs/platform_init ]; then
    cp $PROJECT_DIR/$PROJECT/initramfs/platform_init $INSTALL
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  ln -sf /bin/busybox $INSTALL/usr/bin/env
  cp $PKG_DIR/scripts/pastebinit $INSTALL/usr/bin
  cp $PKG_DIR/scripts/cm-online $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/share/tb
  cp $PKG_DIR/config/functions $INSTALL/usr/share/tb

  mkdir -p $INSTALL/usr/lib/openelec
  cp $PKG_DIR/scripts/fs-resize $INSTALL/usr/lib/openelec
  cp $PKG_DIR/scripts/hostname-setup $INSTALL/usr/lib/openelec

  mkdir -p $INSTALL/etc
  touch $INSTALL/etc/fstab
  cp $PKG_DIR/config/profile $INSTALL/etc
  cp $PKG_DIR/config/hosts $INSTALL/etc
  ln -sf /proc/self/mounts $INSTALL/etc/mtab
  ln -sf /storage/.cache/hostname $INSTALL/etc/hostname
  ln -sf /storage/.cache/machine-id $INSTALL/etc/machine-id
}

post_install() {
  add_user root empty 0 0 "Root User" "/storage" "/bin/sh"
  add_group root 0
  add_group users 100

  add_user nobody x 65534 65534 "Nobody" "/" "/bin/sh"
  add_group nogroup 65534

  enable_service fs-resize.service
  enable_service hostname.service
  enable_service network-online.service
  enable_service autostart.service
}
