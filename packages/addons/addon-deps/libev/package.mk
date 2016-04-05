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

PKG_NAME="libev"
PKG_VERSION="4.22"
PKG_SITE="http://software.schmorp.de/pkg/libev.html"
PKG_URL="http://dist.schmorp.de/libev/libev-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="full-featured and high-performance event loop"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static --with-sysroot=$SYSROOT_PREFIX"
