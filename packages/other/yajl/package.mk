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

PKG_NAME="yajl"
PKG_VERSION="2.1.0"
PKG_SITE="http://lloyd.github.com/yajl/"
PKG_URL="https://github.com/lloyd/yajl/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="yajl: Yet Another JSON Library (YAJL) is a small event-driven (SAX-style) JSON parser"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        ..
}

post_makeinstall_target() {
  mv $SYSROOT_PREFIX/usr/lib/libyajl_s.a $SYSROOT_PREFIX/usr/lib/libyajl.a
  rm $SYSROOT_PREFIX/usr/lib/libyajl.so*

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib
}
