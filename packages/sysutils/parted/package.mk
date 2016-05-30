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

PKG_NAME="parted"
PKG_VERSION="3.2"
PKG_SITE="http://www.gnu.org/software/parted/"
PKG_URL="http://ftp.gnu.org/gnu/parted/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_SHORTDESC="parted: GNU partition editor"

# mess on aarch64
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-device-mapper \
                           --disable-selinux \
                           --disable-dynamic-loading \
                           --disable-debug \
                           --disable-hfs-extract-fs \
                           --disable-shared \
                           --without-readline \
                           --disable-rpath"
