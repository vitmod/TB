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

PKG_NAME="libdvbcsa"
PKG_VERSION="1.1.0"
PKG_SITE="http://www.videolan.org/developers/libdvbcsa.html"
PKG_URL="http://download.videolan.org/pub/videolan/libdvbcsa/${PKG_VERSION}/libdvbcsa-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libdvbcsa is a free implementation of the DVB Common Scrambling Algorithm - DVB/CSA - with encryption and decryption capabilities"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static --with-pic --with-sysroot=$SYSROOT_PREFIX"
