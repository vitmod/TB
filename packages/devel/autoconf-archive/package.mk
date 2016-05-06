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

PKG_NAME="autoconf-archive"
PKG_VERSION="2016.03.20"
PKG_SITE="http://ftp.gnu.org/gnu/autoconf-archive"
PKG_URL="http://ftp.gnu.org/gnu/autoconf-archive/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="autoconf-archive: macros for autoconf"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME --prefix=$ROOT/$TOOLCHAIN"

makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
