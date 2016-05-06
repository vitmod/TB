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

PKG_NAME="lzo"
PKG_VERSION="2.09"
PKG_SITE="http://www.oberhumer.com/opensource/lzo"
PKG_URL="http://www.oberhumer.com/opensource/lzo/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="LZO data compressor"

PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static"
PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"
