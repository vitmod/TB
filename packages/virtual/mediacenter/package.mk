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

PKG_NAME="mediacenter"
PKG_VERSION=""
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi"
PKG_SHORTDESC="mediacenter: metapackage"

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Pillow"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET tb.settings"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET skin.confluence"
