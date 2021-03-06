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

PKG_NAME="opengl-meson8"
PKG_VERSION="r5p1-01rel0-armhf"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/filesystem/"
PKG_URL="http://sources.openelec.tv/devel/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="opengl-meson8: OpenGL ES pre-compiled libraries for Mali 450 GPUs found in Amlogic Meson8 SoCs"

make_target() {
  : # nop
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp -PR usr/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PR usr/lib/*.so* $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
  cp -PR usr/lib/*.so* $INSTALL/usr/lib
}

post_install() {
  enable_service unbind-console.service
}
