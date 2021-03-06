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

PKG_NAME="bwm-ng"
PKG_VERSION="0.6.1"
PKG_SITE="http://www.gropp.org/?id=projects&sub=bwm-ng"
PKG_URL="http://www.gropp.org/bwm-ng/bwm-ng-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_ADDON_REV="3"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nBandwidth Monitor NG is a small and simple console-based live network and disk io bandwidth monitor for Linux, BSD, Solaris, Mac OS X and others."
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="--with-time \
                           --with-getifaddrs \
                           --with-sysctl \
                           --with-sysctldisk \
                           --with-procnetdev \
                           --with-partitions"

pre_configure_target() {
  export LIBS="-lcurses -lterminfo"
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_INSTALL/bin
  cp $PKG_BUILD_SUBDIR/src/bwm-ng $ADDON_INSTALL/bin
}
