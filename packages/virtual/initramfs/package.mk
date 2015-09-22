################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="initramfs"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain glibc:init busybox:init plymouth-lite:init util-linux:init e2fsprogs:init dosfstools:init bkeymaps:init"
PKG_SECTION="virtual"
PKG_SHORTDESC="initramfs: Metapackage for installing initramfs"

post_install() {
  cd $ROOT/$BUILD/initramfs
    if [ "$TARGET_ARCH" = "x86_64" ]; then
      ln -s /lib $ROOT/$BUILD/initramfs/lib64
    fi
    mkdir -p $ROOT/$BUILD/image/
    find . | cpio -H newc -ov -R 0:0 > $ROOT/$BUILD/image/initramfs.cpio
  cd -
}
