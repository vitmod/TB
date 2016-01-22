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

PKG_NAME="aria2"
PKG_VERSION="1.18.8"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="http://aria2.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/aria2/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nA lightweight multi-protocol & multi-source command-line download utility. It supports HTTP/HTTPS, FTP, BitTorrent and Metalink. aria2 can be manipulated via built-in JSON-RPC and XML-RPC interfaces"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="--without-libuv \
                           --without-appletls \
                           --without-wintls \
                           --without-gnutls \
                           --without-libnettle \
                           --without-libgcrypt \
                           --with-openssl \
                           --without-sqlite3 \
                           --disable-xmltest \
                           --without-libexpat \
                           --without-libxml2 \
                           --without-libcares \
                           --with-ca-bundle=$SSL_CERTIFICATES/cacert.pem \
                           --with-gnu-ld"

makeinstall_target() {
  : # meh
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -PR $PKG_BUILD/.$TARGET_NAME/src/aria2c $ADDON_BUILD/$PKG_ADDON_ID/bin
}
