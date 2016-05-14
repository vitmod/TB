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

PKG_NAME="e2fsprogs"
PKG_VERSION="1.42.13"
PKG_SITE="http://e2fsprogs.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME/1.42/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain e2fsprogs"
PKG_SHORTDESC="e2fsprogs: Utilities for use with the ext2 filesystem"

PKG_CONFIGURE_OPTS_TARGET="BUILD_CC=$HOST_CC \
                           --prefix=/usr \
                           --enable-verbose-makecmds \
                           --enable-symlink-install \
                           --enable-symlink-build \
                           --enable-compression \
                           --enable-htree \
                           --disable-elf-shlibs \
                           --disable-bsd-shlibs \
                           --disable-profile \
                           --disable-jbd-debug \
                           --disable-blkid-debug \
                           --disable-testio-debug \
                           --enable-libuuid \
                           --enable-libblkid \
                           --disable-debugfs \
                           --disable-imager \
                           --enable-resizer \
                           --enable-fsck \
                           --disable-e2initrd-helper \
                           --enable-tls \
                           --disable-uuidd \
                           --disable-nls \
                           --disable-rpath \
                           --with-gnu-ld"

post_makeinstall_target() {
  REMOVE_BIN="badblocks blkid dumpe2fs e2freefrag e2undo e4defrag filefrag fsck logsave mklost+foun"
  for i in $REMOVE_BIN ; do
    rm -rf $INSTALL/usr/sbin/$i
  done
}

configure_init() {
  : # use target
}

make_init() {
  : # use target
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
  cp $PKG_BUILD/.$TARGET_NAME/e2fsck/e2fsck $INSTALL/bin
}
