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

PKG_NAME="libusb"
PKG_VERSION="1.0.20"
PKG_SITE="http://libusb.info/"
PKG_URL="https://github.com/$PKG_NAME/$PKG_NAME/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libusb: OS independent USB device access"

MAKEFLAGS=-j1

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static \
                           --disable-log \
                           --disable-debug-log \
                           --disable-udev \
                           --disable-examples-build"
