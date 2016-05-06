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

PKG_NAME="timezone-data"
PKG_VERSION="2014i"
PKG_SITE="ftp://elsie.nci.nih.gov/pub/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="timezone-data"

make_target() {
  setup_toolchain host
  make CC="$HOST_CC" CFLAGS="$HOST_CFLAGS"
}

makeinstall_target() {
  make TOPDIR="./.install_pkg" install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/zoneinfo
  mv $INSTALL/etc/zoneinfo/* $INSTALL/usr/share/zoneinfo

  rm -rf $INSTALL/etc
  mkdir -p $INSTALL/etc
  ln -sf /storage/.cache/localtime $INSTALL/etc/localtime
}
