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

PKG_NAME="visualization.waveform"
PKG_VERSION="a603d10"
PKG_SITE="http://www.kodi.tv"
PKG_FETCH="https://github.com/notspiff/visualization.waveform.git"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SHORTDESC=""

PKG_IS_ADDON="yes"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        ..
}

addon() {
  mkdir -p $ADDON_INSTALL
  cp -R $INSTALL/usr/share/kodi/addons/$PKG_NAME/* $ADDON_INSTALL

  ADDONSO=$(xmlstarlet sel -t -v "/addon/extension/@library_linux" $ADDON_INSTALL/addon.xml)
  cp -L $INSTALL/usr/lib/kodi/addons/$PKG_NAME/$ADDONSO $ADDON_INSTALL
}
