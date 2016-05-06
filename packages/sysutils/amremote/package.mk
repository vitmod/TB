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

PKG_NAME="amremote"
PKG_VERSION="ecdf401"
PKG_SITE="http://www.amlogic.com"
PKG_FETCH="git+https://github.com/codesnake/amremote.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="amremote - IR remote configuration utility for Amlogic-based devices"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp remotecfg $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/lib/openelec
  cp $PKG_DIR/scripts/* $INSTALL/usr/lib/openelec
}

post_install() {
  enable_service amlogic-remotecfg.service
}
