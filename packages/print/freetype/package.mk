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

PKG_NAME="freetype"
PKG_VERSION="2.6.3"
PKG_SITE="http://www.freetype.org"
PKG_URL="http://download.savannah.gnu.org/releases/freetype/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_SHORTDESC="freetype: TrueType font rendering library"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
                           --with-zlib --with-png=no"

post_makeinstall_target() {
  rm -f $SYSROOT_PREFIX/usr/bin/freetype-config
  rm -rf $INSTALL/usr/bin
}
