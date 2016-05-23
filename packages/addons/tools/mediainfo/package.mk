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

PKG_NAME="mediainfo"
PKG_VERSION="0.7.84"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_URL="http://mediaarea.net/download/source/mediainfo/$PKG_VERSION/mediainfo_$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="MediaInfo"
PKG_DEPENDS_TARGET="toolchain libmediainfo"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="4"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nMediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_SCRIPT="Project/GNU/CLI/configure"

pre_configure_target() {
  cd $PKG_BUILD/Project/GNU/CLI
  do_autoreconf
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_INSTALL/bin
  cp $PKG_BUILD/Project/GNU/CLI/mediainfo $ADDON_INSTALL/bin
}
