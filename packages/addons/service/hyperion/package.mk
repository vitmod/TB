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

PKG_NAME="hyperion"
PKG_VERSION="8865ff4"
PKG_REV="0"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tvdzwan/hyperion"
PKG_FETCH="git+https://github.com/tvdzwan/hyperion.git"
PKG_DEPENDS_TARGET="toolchain libusb qt"
PKG_SECTION="service"
PKG_SHORTDESC="hyperion: an ambilight controller"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nHyperion is an opensource 'AmbiLight' implementation"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Hyperion daemon"
PKG_ADDON_TYPE="xbmc.service"

PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        -DENABLE_AMLOGIC=1 \
        -DENABLE_DISPMANX=0 \
        -DENABLE_FB=1 \
        -DENABLE_OSX=0 \
        -DENABLE_PROTOBUF=0 \
        -DENABLE_SPIDEV=0 \
        -DENABLE_TINKERFORGE=0 \
        -DENABLE_V4L2=0 \
        -DENABLE_WS2812BPWM=0 \
        -DENABLE_WS281XPWM=0 \
        -DENABLE_X11=0 \
        -DENABLE_QT5=0 \
        -Wno-dev \
        ..
}


makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/bin/hyperiond $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/bin/hyperion-remote $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
  cp -P $PKG_BUILD/config/hyperion.config.json $ADDON_BUILD/$PKG_ADDON_ID/config

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/effects
  cp -PR $PKG_BUILD/effects/* $ADDON_BUILD/$PKG_ADDON_ID/effects

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
