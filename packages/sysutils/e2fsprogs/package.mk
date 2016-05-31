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
PKG_VERSION="1.43"
PKG_SITE="https://github.com/tytso/e2fsprogs"
PKG_URL="https://github.com/tytso/e2fsprogs/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_INIT="toolchain"
PKG_SHORTDESC="e2fsprogs: Utilities for use with the ext2 filesystem"

PKG_CONFIGURE_OPTS_INIT="BUILD_CC=$HOST_CC \
                         ac_cv_path_PERL= \
                         --prefix=/usr \
                         --enable-symlink-install \
                         --enable-symlink-build \
                         --disable-elf-shlibs \
                         --disable-bsd-shlibs \
                         --disable-profile \
                         --disable-jbd-debug \
                         --disable-blkid-debug \
                         --disable-testio-debug \
                         --enable-libuuid \
                         --enable-libblkid \
                         --disable-backtrace \
                         --disable-debugfs \
                         --disable-imager \
                         --enable-resizer \
                         --disable-defrag \
                         --enable-fsck \
                         --disable-e2initrd-helper \
                         --enable-tls \
                         --disable-uuidd \
                         --disable-mmp \
                         --disable-bmap-stats \
                         --disable-nls \
                         --disable-rpath \
                         --disable-fuse2fs"

makeinstall_init() {
  mkdir -p $INSTALL/bin
  cp $PKG_BUILD_SUBDIR/e2fsck/e2fsck $INSTALL/bin
}
