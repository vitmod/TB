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

PKG_NAME="libamcodec"
PKG_VERSION="5e23a81"
PKG_SITE="http://openlinux.amlogic.com"
PKG_FETCH="git+https://github.com/codesnake/libamcodec.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libamcodec: Interface library for Amlogic media codecs"

make_target() {
  make -C amavutils CC="$CC" PREFIX="$SYSROOT_PREFIX/usr"
  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PR amavutils/*.so $SYSROOT_PREFIX/usr/lib

  make -C amadec CC="$CC" PREFIX="$SYSROOT_PREFIX/usr" CROSS_PREFIX="$TARGET_PREFIX" install
  make -C amcodec CC="$CC" HEADERS_DIR="$SYSROOT_PREFIX/usr/include/amcodec" PREFIX="$SYSROOT_PREFIX/usr" CROSS_PREFIX="$TARGET_PREFIX" install
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp -PR amavutils/*.so $INSTALL/usr/lib

  make -C amadec PREFIX="$INSTALL/usr" install
  make -C amcodec HEADERS_DIR="$INSTALL/usr/include/amcodec" PREFIX="$INSTALL/usr" install

  # wtf
  chmod u+w $INSTALL/usr/lib/libamadec.so
}
