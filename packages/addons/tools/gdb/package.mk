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

PKG_NAME="gdb"
PKG_VERSION="7.11"
PKG_SITE="http://www.gnu.org/software/gdb/"
PKG_URL="http://ftp.gnu.org/gnu/gdb/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib ncurses"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="3"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nThe purpose of a debugger such as GDB is to allow you to see what is going on ``inside'' another program while it executes--or what another program was doing @ the moment it crashed."
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="bash_cv_have_mbstate_t=set \
                           --disable-shared \
                           --enable-static \
                           --with-auto-load-safe-path=/ \
                           --datarootdir=/storage/.kodi/addons/tools.gdb/data \
                           --disable-nls \
                           --disable-sim \
                           --without-x \
                           --disable-tui \
                           --disable-libada \
                           --without-lzma \
                           --disable-libquadmath \
                           --disable-libquadmath-support \
                           --without-expat \
                           --without-libexpat-prefix \
                           --disable-libssp \
                           --disable-werror"

pre_configure_target() {
  export CC_FOR_BUILD="$HOST_CC"
  export CFLAGS_FOR_BUILD="$HOST_CFLAGS"
}

makeinstall_target() {
  : # meh
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/gdb/gdb $ADDON_BUILD/$PKG_ADDON_ID/bin/

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/data/gdb
  cp -R $PKG_BUILD/.$TARGET_NAME/gdb/data-directory/syscalls $ADDON_BUILD/$PKG_ADDON_ID/data/gdb/
}
