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

PKG_NAME="util-linux"
PKG_VERSION="2.28"
PKG_URL="http://www.kernel.org/pub/linux/utils/util-linux/v2.28/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="util-linux: Miscellaneous system utilities for Linux"

PKG_CONFIGURE_OPTS_TARGET="--libdir=/usr/lib \
                           --disable-gtk-doc \
                           --disable-nls \
                           --disable-rpath \
                           --enable-tls \
                           --disable-all-programs \
                           --enable-chsh-only-listed \
                           --enable-libmount-force-mountinfo \
                           --disable-bash-completion \
                           --disable-colors-default \
                           --disable-pylibmount \
                           --disable-pg-bell \
                           --disable-use-tty-group \
                           --disable-makeinstall-chown \
                           --disable-makeinstall-setuid \
                           --without-selinux \
                           --without-audit \
                           --without-udev \
                           --without-ncurses \
                           --without-readline \
                           --without-slang \
                           --without-tinfo \
                           --without-utempter \
                           --without-util \
                           --without-libz \
                           --without-user \
                           --without-systemd \
                           --without-smack \
                           --without-python \
                           --without-systemdsystemunitdir \
                           --enable-libuuid \
                           --enable-libblkid \
                           --enable-libmount \
                           --disable-libfdisk"
