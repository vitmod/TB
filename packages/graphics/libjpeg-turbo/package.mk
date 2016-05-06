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

PKG_NAME="libjpeg-turbo"
PKG_VERSION="1.4.2"
PKG_SITE="http://libjpeg-turbo.virtualgl.org/"
PKG_URL="$SOURCEFORGE_SRC/libjpeg-turbo/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libjpeg-turbo: a high-speed version of libjpeg"

PKG_CONFIGURE_OPTS_HOST="--enable-static \
                         --disable-shared \
                         --with-jpeg8 \
                         --without-simd"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-jpeg8"

pre_configure_target() {
  export CPPFLAGS="$CPPFLAGS -fPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
