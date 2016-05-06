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

PKG_NAME="zlib"
PKG_VERSION="1.2.8"
PKG_SITE="http://www.zlib.net"
PKG_URL="http://zlib.net/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="zlib: A general purpose (ZIP) data compression library"

TARGET_CONFIGURE_OPTS="--prefix=/usr"
HOST_CONFIGURE_OPTS="--prefix=$ROOT/$TOOLCHAIN"

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

pre_build_host() {
  mkdir -p $PKG_BUILD/.$HOST_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$HOST_NAME
}
