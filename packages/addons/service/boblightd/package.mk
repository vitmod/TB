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

PKG_NAME="boblightd"
PKG_VERSION="479"
PKG_REV="3"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/boblight"
PKG_FETCH="svn+http://boblight.googlecode.com/svn/trunk"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="service"
PKG_SHORTDESC="boblightd: an ambilight controller."
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nBoblight's main purpose is to create light effects from an external input, such as a video stream"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Boblight daemon"
PKG_ADDON_TYPE="xbmc.service"

PKG_AUTORECONF="yes"

PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

PKG_CONFIGURE_OPTS_TARGET="--without-opengl --without-x11 --without-portaudio"

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -P $PKG_BUILD/.$TARGET_NAME/src/.libs/libboblight.so* $ADDON_BUILD/$PKG_ADDON_ID/lib

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/src/boblightd $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/src/boblight-constant $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/src/boblight-aml $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
  cp -R $PKG_DIR/config/boblight.conf $ADDON_BUILD/$PKG_ADDON_ID/config
}
