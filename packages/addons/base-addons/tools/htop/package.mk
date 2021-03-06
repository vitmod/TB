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

PKG_NAME="htop"
PKG_VERSION="1.0.3"
PKG_SITE="http://htop.sourceforge.net/"
PKG_URL="http://hisham.hm/htop/releases/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_ADDON_REV="3"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nHtop is an ncurses based interactive process viewer for Linux."
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="--enable-cgroup \
                           --disable-vserver \
                           --disable-unicode \
                           --disable-native-affinity \
                           --disable-hwloc"

pre_configure_target() {
  rm -rf $PKG_BUILD_SUBDIR
  export LIBS="-lcurses -lterminfo"
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_INSTALL/bin
  cp $PKG_BUILD/htop $ADDON_INSTALL/bin
}
