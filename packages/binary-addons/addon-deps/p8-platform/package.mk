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

PKG_NAME="p8-platform"
PKG_VERSION="041a8c6"
PKG_SITE="http://www.kodi.tv"
PKG_FETCH="git+https://github.com/Pulse-Eight/platform.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC=""

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DBUILD_SHARED_LIBS=0 \
        ..
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
