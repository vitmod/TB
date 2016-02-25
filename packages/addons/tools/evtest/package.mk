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

PKG_NAME="evtest"
PKG_VERSION="1.31"
PKG_REV="2"
PKG_LICENSE="GPL"
PKG_SITE="http://cgit.freedesktop.org/evtest/"
PKG_URL="http://cgit.freedesktop.org/evtest/snapshot/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nevtest is a simple tool for input event debugging."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_AUTORECONF="yes"

PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/evtest $ADDON_BUILD/$PKG_ADDON_ID/bin
}
