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

PKG_NAME="hid_mapper"
PKG_VERSION="0"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://www.coldsource.net/hid_mapper.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}_beta"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="generic HID mapper"
PKG_LONGDESC="generic HID mapper"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

makeinstall_target() {
  : # nope
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/hid_mapper $ADDON_BUILD/$PKG_ADDON_ID/bin
}
