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

PKG_NAME="ngrep"
PKG_VERSION="1.45"
PKG_SITE="http://ngrep.sourceforge.net/"
PKG_URL="http://prdownloads.sourceforge.net/ngrep/ngrep-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="2"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nngrep strives to provide most of GNU grep's common features, applying them to the network layer."
PKG_ADDON_SECTION="tools"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="--with-pcap-includes=$SYSROOT_PREFIX/usr/include --disable-dropprivs"

pre_configure_target() {
  rm -rf $PKG_BUILD/.$TARGET_NAME
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_INSTALL/bin
  cp $PKG_BUILD/ngrep $ADDON_INSTALL/bin
}
