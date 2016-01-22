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

PKG_NAME="axel"
PKG_VERSION="2.4"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="http://freecode.com/projects/axel"
PKG_URL="http://pkgs.fedoraproject.org/repo/pkgs/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz/a2a762fce0c96781965c8f9786a3d09d/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nAxel tries to accelerate downloads by using multiple connections (possibly to multiple servers) for one download. Because of its size, it might be very useful on bootdisks or other small systems as a wget replacement"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME
}

configure_target() {
  ./configure --prefix=/usr --strip=0 --i18n=0
}

makeinstall_target() {
  : # meh
}

post_makeinstall_target() {
  $STRIP axel
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -PR $PKG_BUILD/axel $ADDON_BUILD/$PKG_ADDON_ID/bin
}
