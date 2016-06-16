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

PKG_NAME="tz"
PKG_VERSION="2016e"
PKG_SITE="https://www.iana.org/time-zones"
PKG_URL="https://github.com/eggert/tz/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="tz"

make_target() {
  setup_toolchain host
  make CC="$HOST_CC" CFLAGS="$HOST_CFLAGS"
}

makeinstall_target() {
  make TOPDIR="$INSTALL" install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/zoneinfo
  mv $INSTALL/etc/zoneinfo/* $INSTALL/usr/share/zoneinfo

  rm -rf $INSTALL/etc
  mkdir -p $INSTALL/etc
  ln -sf /storage/.cache/localtime $INSTALL/etc/localtime
}
