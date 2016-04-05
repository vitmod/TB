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

PKG_NAME="strace"
PKG_VERSION="4.10"
PKG_SITE="http://sourceforge.net/projects/strace/"
PKG_URL="$SOURCEFORGE_SRC/strace/strace/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="2"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nIn the simplest case strace runs the specified command until it exits. It intercepts and records the system calls which are called by a process and the signals which are received by a process. The name of each system call, its arguments and its return value are printed on standard error or to the file specified with the -o option."
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/strace $ADDON_BUILD/$PKG_ADDON_ID/bin
}
