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

PKG_NAME="bitstream"
PKG_VERSION="1.1"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org"
PKG_URL="http://download.videolan.org/pub/videolan/${PKG_NAME}/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="biTStream is a set of C headers allowing a simpler access to binary structures such as specified by MPEG, DVB, IETF, etc."

PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"
