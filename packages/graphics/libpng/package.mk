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

PKG_NAME="libpng"
PKG_VERSION="1.6.21"
PKG_SITE="http://www.libpng.org/"
PKG_URL="$SOURCEFORGE_SRC/libpng/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_SHORTDESC="libpng: Portable Network Graphics (PNG) Reference Library"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_lib_z_zlibVersion=yes \
                           --enable-static --disable-shared \
                           --with-sysroot=$SYSROOT_PREFIX"

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared"

pre_configure_host() {
  export CPPFLAGS="$CPPFLAGS -I$ROOT/$TOOLCHAIN/include"
}

pre_configure_target() {
  export CPPFLAGS="$CPPFLAGS -fPIC"
}

post_makeinstall_host() {
  rm -rf $ROOT/$TOOLCHAIN/bin/libpng*-config
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $SYSROOT_PREFIX/usr/bin/libpng*-config
}
