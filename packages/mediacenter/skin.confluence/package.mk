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

PKG_NAME="skin.confluence"
PKG_VERSION="046115e"
PKG_SITE="http://www.kodi.tv"
PKG_FETCH="https://github.com/xbmc/skin.confluence.git"
PKG_DEPENDS_TARGET="toolchain kodi:host"
PKG_SHORTDESC=""

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/skin.confluence
  cp -PR $PKG_BUILD/* $INSTALL/usr/share/kodi/addons/skin.confluence
  TexturePacker -input $INSTALL/usr/share/kodi/addons/skin.confluence/media/ \
   -output $INSTALL/usr/share/kodi/addons/skin.confluence/media/Textures.xbt -dupecheck && \
   find $INSTALL/usr/share/kodi/addons/skin.confluence/media -not -iname "*.xbt" -exec rm -f {} \; 2>/dev/null || :
}
