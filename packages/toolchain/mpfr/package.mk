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

PKG_NAME="mpfr"
PKG_VERSION="3.1.4"
PKG_SITE="http://www.mpfr.org/"
PKG_URL="http://ftp.gnu.org/gnu/mpfr/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="gmp:host"
PKG_SHORTDESC="mpfr: A C library for multiple-precision floating-point computations with exact roundi"

PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static --target=$TARGET_NAME"
