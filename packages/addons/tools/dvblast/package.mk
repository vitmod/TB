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

PKG_NAME="dvblast"
PKG_VERSION="3.0"
PKG_SITE="http://www.videolan.org"
PKG_URL="http://downloads.videolan.org/pub/videolan/dvblast/${PKG_VERSION}/dvblast-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain bitstream libev"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="2"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nDVBlast is a simple and powerful MPEG-2/TS demux and streaming application"
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

pre_configure_target() {
  export LDLIBS="$LDLIBS -lm"
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/dvblast $ADDON_BUILD/$PKG_ADDON_ID/bin/
}
