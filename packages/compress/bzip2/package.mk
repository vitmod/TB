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

PKG_NAME="bzip2"
PKG_VERSION="1.0.6"
PKG_LICENSE="GPL"
PKG_SITE="http://www.bzip.org"
PKG_URL="http://www.bzip.org/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="bzip2 data compressor"

make_target() {
  make CC=$TARGET_CC CFLAGS="$CFLAGS -fPIC -DPIC" libbz2.a
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp bzlib.h $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -P libbz2.a* $SYSROOT_PREFIX/usr/lib
}
