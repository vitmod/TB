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

PKG_NAME="pvr.iptvsimple"
PKG_VERSION="5ee3a53"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="git+https://github.com/kodi-pvr/pvr.iptvsimple.git"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kodi-platform zlib"
PKG_SECTION=""
PKG_SHORTDESC=""

PKG_IS_ADDON="yes"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        ..
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/
  cp -PR $PKG_BUILD/.install_pkg/usr/share/kodi/addons/$PKG_NAME/* $ADDON_BUILD/$PKG_ADDON_ID/
  cp -PL $PKG_BUILD/.install_pkg/usr/lib/kodi/addons/$PKG_NAME/*.so $ADDON_BUILD/$PKG_ADDON_ID/
}
