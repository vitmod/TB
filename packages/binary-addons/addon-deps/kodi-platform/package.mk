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

PKG_NAME="kodi-platform"
PKG_VERSION="92583ef"
PKG_SITE="http://www.kodi.tv"
PKG_FETCH="git+https://github.com/xbmc/kodi-platform.git"
PKG_DEPENDS_TARGET="toolchain tinyxml kodi p8-platform"
PKG_SHORTDESC=""

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_PREFIX_TOOLCHAIN=$SYSROOT_PREFIX/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DBUILD_SHARED_LIBS=0 \
        ..
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/kodiplatform
}
