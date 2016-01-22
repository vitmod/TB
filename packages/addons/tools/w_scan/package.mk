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

PKG_NAME="w_scan"
PKG_VERSION="20141122"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/w_scan/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/w_scan/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nw_scan is a small command line utility used to perform frequency scans for DVB and ATSC transmissions"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/w_scan $ADDON_BUILD/$PKG_ADDON_ID/bin
}
