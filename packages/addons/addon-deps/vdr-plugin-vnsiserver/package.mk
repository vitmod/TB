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

PKG_NAME="vdr-plugin-vnsiserver"
PKG_VERSION="d96f211"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FernetMenta/vdr-plugin-vnsiserver"
PKG_URL="http://saraev.ca/openelec/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_SHORTDESC="TV"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include

  make ${LIB_NAME}.so
  cp --remove-destination $ROOT/$PKG_BUILD/${LIB_NAME}.so $ROOT/$PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}

makeinstall_target() {
  : # meh
}
