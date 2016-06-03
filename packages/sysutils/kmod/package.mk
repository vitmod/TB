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

PKG_NAME="kmod"
PKG_VERSION="22"
PKG_SITE="http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git"
PKG_URL="http://ftp.kernel.org/pub/linux/utils/kernel/kmod/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Program to manage Linux Kernel modules"

PKG_CONFIGURE_OPTS_COMMON="--enable-tools \
                           --enable-logging \
                           --disable-debug \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-gtk-doc-pdf \
                           --disable-manpages \
                           --disable-test-modules \
                           --without-xz \
                           --without-zlib"

PKG_CONFIGURE_OPTS_HOST="$PKG_CONFIGURE_OPTS_COMMON"
PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_COMMON"

post_makeinstall_host() {
  ln -sf kmod $ROOT/$TOOLCHAIN/bin/depmod
}

post_makeinstall_target() {
  # make symlinks for compatibility
  mkdir -p $INSTALL/sbin
  for i in lsmod insmod rmmod modinfo modprobe ; do
    ln -sf /usr/bin/kmod $INSTALL/sbin/$i
  done
}
