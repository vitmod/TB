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

PKG_NAME="expat"
PKG_VERSION="2.1.1"
PKG_SITE="http://expat.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="expat: XML parser library"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
