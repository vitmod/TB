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

PKG_NAME="screen"
PKG_VERSION="4.3.1"
PKG_SITE="http://www.gnu.org/software/screen/"
PKG_URL="http://ftp.gnu.org/gnu/screen/screen-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="3"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nscreen is a terminal multiplexor that runs several separate "screens" on a single physical character-based terminal. Each virtual terminal emulates a DEC VT100 plus several ANSI X3.64 and ISO 2022 functions. Screen sessions can be detached and resumed later on a different terminal."
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_utempter_h=no \
                           --disable-pam \
                           --disable-use-locale \
                           --disable-telnet \
                           --disable-socket-dir"

pre_configure_target() {
  rm -rf $PKG_BUILD/.$TARGET_NAME
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/screen $ADDON_BUILD/$PKG_ADDON_ID/bin/screen
}
