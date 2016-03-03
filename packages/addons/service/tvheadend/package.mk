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

PKG_NAME="tvheadend"
PKG_VERSION="52ed773"
PKG_REV="3"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvheadend.org"
PKG_FETCH="git+https://github.com/tvheadend/tvheadend.git"
PKG_DEPENDS_TARGET="toolchain libressl curl libdvbcsa"
PKG_SECTION="service"
PKG_SHORTDESC="TV streaming server for Linux"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nTvheadend is a TV streaming server for Linux supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC and IPTV."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tvheadend PVR Backend"
PKG_ADDON_TYPE="xbmc.service"

PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

pre_build_target() {
  sed -e 's/VER="0.0.0~unknown"/VER="'$PKG_VERSION'"/g' -i $PKG_BUILD/support/version
  export CROSS_COMPILE=$TARGET_PREFIX
}

pre_configure_target() {
  rm -rf $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
  ./configure --prefix=/usr \
            --arch=$TARGET_ARCH \
            --cpu=$TARGET_CPU \
            --cc=$TARGET_CC \
            --disable-satip_server \
            --disable-satip_client \
            --disable-hdhomerun_client \
            --disable-hdhomerun_static \
            --disable-trace \
            --disable-avahi \
            --disable-libav \
            --disable-libffmpeg_static \
            --disable-libx264_static \
            --disable-libx265_static \
            --disable-vdpau \
            --disable-nvenc \
            --disable-libmfx_static \
            --enable-inotify \
            --enable-epoll \
            --disable-uriparser \
            --disable-ccache \
            --enable-tvhcsa \
            --enable-bundle \
            --enable-dvbcsa \
            --disable-dvben50221 \
            --disable-dbus_1 \
            --python=$ROOT/$TOOLCHAIN/bin/python
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/build.linux/tvheadend $ADDON_BUILD/$PKG_ADDON_ID/bin
}
