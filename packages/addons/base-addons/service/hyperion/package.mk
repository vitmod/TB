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
PKG_VERSION="667ee80"
PKG_SITE="https://github.com/hyperion-project/hyperion"
PKG_FETCH="https://github.com/hyperion-project/hyperion.git"
PKG_DEPENDS_TARGET="toolchain Python libusb qt"
PKG_SHORTDESC="hyperion: an ambilight controller"

PKG_IS_ADDON="yes"
PKG_ADDON_REV="5"
PKG_ADDON_NAME="Hyperion daemon"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_DESC="$PKG_NAME-$PKG_VERSION\nHyperion is an opensource 'AmbiLight' implementation"
PKG_ADDON_MAINTAINER="Stefan Saraev (seo @ freenode)"
PKG_ADDON_SECTION="service"

configure_target() {
  echo "" > ../cmake/FindGitVersion.cmake
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DHYPERION_VERSION_ID="$PKG_VERSION" \
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
        -DENABLE_TESTS=0 \
        -Wno-dev \
        ..
}


makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_INSTALL/bin
  cp $PKG_BUILD_SUBDIR/bin/hyperiond $ADDON_INSTALL/bin
  cp $PKG_BUILD_SUBDIR/bin/hyperion-remote $ADDON_INSTALL/bin

  mkdir -p $ADDON_INSTALL/config
  cp $PKG_BUILD/config/hyperion.config.json $ADDON_INSTALL/config/hyperion.config.json
  sed -i -e "s,/opt/hyperion/effects,/storage/.kodi/addons/service.hyperion/effects,g" \
    $ADDON_INSTALL/config/hyperion.config.json

  mkdir -p $ADDON_INSTALL/effects
  cp -R $PKG_BUILD/effects/* $ADDON_INSTALL/effects
}