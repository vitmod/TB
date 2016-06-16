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

PKG_NAME="pcre"
PKG_VERSION="8.38"
PKG_SITE="http://www.pcre.org/"
PKG_URL="http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="pcre: Perl Compatible Regulat Expressions"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static \
                           --enable-utf8 \
                           --enable-pcre16 \
                           --enable-unicode-properties"

post_makeinstall_target() {
  rm -rf $SYSROOT_PREFIX/usr/bin/pcre-config
  rm -rf $INSTALL/usr/bin
}
