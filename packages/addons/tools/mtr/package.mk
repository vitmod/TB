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

PKG_NAME="mtr"
PKG_VERSION="0.86"
PKG_SITE="http://www.bitwizard.nl/mtr/"
PKG_URL="ftp://ftp.bitwizard.nl/mtr/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_SECTION="tools"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="0"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nmtr combines the functionality of the 'traceroute' and 'ping' programs in a single network diagnostic tool"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="--disable-gtktest \
                           --without-gtk"

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/mtr $ADDON_BUILD/$PKG_ADDON_ID/bin
  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
