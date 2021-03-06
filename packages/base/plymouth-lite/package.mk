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

PKG_NAME="plymouth-lite"
PKG_VERSION="0.6.0"
PKG_SITE="http://www.meego.com"
PKG_URL="http://sources.openelec.tv/devel/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_INIT="toolchain libpng"
PKG_SHORTDESC="plymouth-lite: Boot splash screen based on Fedora's Plymouth code"

pre_configure_init() {
  rm -rf $PKG_BUILD_SUBDIR
}

make_init() {
  $CC $CFLAGS ply-image.c ply-frame-buffer.c -o ply-image \
    -Wl,-Bstatic -lpng -lm -lz -Wl,-Bdynamic $LDFLAGS
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
  cp ply-image $INSTALL/bin

  mkdir -p $INSTALL/splash
  cp $ROOT/config/splash.png $INSTALL/splash
}
