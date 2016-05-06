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

PKG_NAME="m4"
PKG_VERSION="1.4.17"
PKG_SITE="ftp://ftp.gnu.org/pub/gnu/m4/"
PKG_URL="http://ftp.gnu.org/gnu/m4/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="m4: The m4 macro processor"

PKG_CONFIGURE_OPTS_HOST="gl_cv_func_gettimeofday_clobber=no --target=$TARGET_NAME"

post_makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
