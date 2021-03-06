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

PKG_NAME="binutils"
PKG_VERSION="2.26"
PKG_SITE="http://www.gnu.org/software/binutils/binutils.html"
PKG_URL="http://ftp.gnu.org/gnu/binutils/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="linux:host"
PKG_SHORTDESC="binutils: A GNU collection of binary utilities"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --with-sysroot=$SYSROOT_PREFIX \
                         --with-lib-path=$SYSROOT_PREFIX/lib:$SYSROOT_PREFIX/usr/lib \
                         --without-ppl \
                         --without-cloog \
                         --disable-werror \
                         --disable-multilib \
                         --disable-libquadmath \
                         --disable-libquadmath-support \
                         --disable-libada \
                         --disable-libssp \
                         --disable-gold \
                         --disable-lto \
                         --disable-nls"

pre_configure_host() {
  unset CPPFLAGS
  unset CFLAGS
  unset CXXFLAGS
  unset LDFLAGS
}

pre_make_host() {
  make configure-host
}
