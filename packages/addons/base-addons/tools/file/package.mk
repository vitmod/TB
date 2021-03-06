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

PKG_NAME="file"
PKG_VERSION="5.26"
PKG_SITE="http://www.darwinsys.com/file/"
PKG_URL="ftp://ftp.astron.com/pub/file/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain zlib file:host"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_ADDON_REV="3"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nThe file(1) utility is used to determine the types of various files."
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static"
PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

makeinstall_target() {
  : # meh
}

addon() {
  mkdir -p $ADDON_INSTALL/bin
  cp -R $PKG_BUILD_SUBDIR/src/file $ADDON_INSTALL/bin
  mkdir -p $ADDON_INSTALL/data
  cp -R $PKG_BUILD_SUBDIR/magic/magic.mgc $ADDON_INSTALL/data
}
