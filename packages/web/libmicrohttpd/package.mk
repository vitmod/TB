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

PKG_NAME="libmicrohttpd"
PKG_VERSION="0.9.49"
PKG_SITE="https://www.gnu.org/software/libmicrohttpd/"
PKG_URL="https://ftp.gnu.org/gnu/libmicrohttpd/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libmicrohttpd: a small webserver C library"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --disable-doc \
                           --disable-examples \
                           --disable-curl \
                           --disable-https"
