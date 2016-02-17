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

PKG_NAME="oscam"
PKG_VERSION="11209"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="svn+http://www.streamboard.tv/svn/oscam/trunk"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="service"
PKG_SHORTDESC="$PKG_NAME-$PKG_VERSION"
PKG_LONGDESC="$PKG_NAME-$PKG_VERSION\nOSCam is an Open Source Conditional Access Module software"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="OSCam"
PKG_ADDON_TYPE="xbmc.service"

PKG_DISCLAIMER="using oscam may be illegal in your country. if in doubt, do not install"
PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

pre_package() {
  echo r$REV > VERSION
}

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DLIBUSBDIR=$SYSROOT_PREFIX/usr \
        -DMODULE_CONSTCW=0 \
        -DMODULE_GBOX=0 \
        -DMODULE_GHTTP=0 \
        -DMODULE_MONITOR=0 \
        -DMODULE_PANDORA=0 \
        -DMODULE_RADEGAST=0 \
        -DMODULE_SERIAL=0 \
        -DMODULE_SCAM=0 \
        -DCARDREADER_DB2COM=0 \
        -DCARDREADER_MP35=0 \
        -DCARDREADER_PCSC=0 \
        -DCARDREADER_SC8IN1=0 \
        -DCARDREADER_STINGER=0 \
        -DCARDREADER_STAPI=0 \
        -DCARDREADER_STAPI5=0 \
        -DWITH_LB=0 \
        -DWITH_SSL=0 \
        -DWITH_DEBUG=0 \
        -DCS_ANTICASC=0 \
        -DCS_CACHEEX=0 \
        -DCW_CYCLE_CHECK=0 \
        -DHAVE_LIBCRYPTO=0 \
        -DHAVE_DVBAPI=1 -DWITH_STAPI=0 \
        -DWEBIF=1 \
        -DCS_CONFDIR=/storage/.kodi/userdata/addon_data/service.oscam/config \
        -DSTATIC_LIBUSB=1 \
        -DCLOCKFIX=0 \
        ..
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/oscam $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/utils/list_smargo $ADDON_BUILD/$PKG_ADDON_ID/bin
}
