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

PKG_NAME="libmediainfo"
PKG_VERSION="0.7.84"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_URL="http://mediaarea.net/download/source/libmediainfo/$PKG_VERSION/libmediainfo_$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="MediaInfoLib"
PKG_DEPENDS_TARGET="toolchain libzen"
PKG_SHORTDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"

PKG_CONFIGURE_SCRIPT="Project/GNU/Library/configure"
PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --enable-visibility \
                           --without-libcurl \
                           --without-libmms \
                           --without-libtinyxml2"

pre_configure_target() {
  cd $PKG_BUILD/Project/GNU/Library
  do_autoreconf
}

post_makeinstall_target() {
  cp libmediainfo-config $ROOT/$TOOLCHAIN/bin
}
