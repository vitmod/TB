################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="kodi"
PKG_VERSION="17.0-alpha1-a052938"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kodi:host swig:host"
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_SHORTDESC="kodi: Kodi Mediacenter"

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET alsa bzip2 crossguid curl dbus ffmpeg"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET fontconfig freetype fribidi libass"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libcdio libogg libpng libvorbis"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libxml2 libxslt lzo pcre Python sqlite"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET systemd taglib tinyxml yajl zlib libsquish"

if [ -n "$OPENGLES" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
  KODI_CONFIG="$KODI_CONFIG --enable-gles"
else
  KODI_CONFIG="$KODI_CONFIG --disable-gles"
fi

if [ "$KODI_WEBSERVER_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libmicrohttpd"
  KODI_CONFIG="$KODI_CONFIG --enable-webserver"
else
  KODI_CONFIG="$KODI_CONFIG --disable-webserver"
fi

if [ -n "$KODIPLAYER_DRIVER" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $KODIPLAYER_DRIVER"
fi
if [ "$KODIPLAYER_DRIVER" = libamcodec ]; then
  KODI_CONFIG="$KODI_CONFIG --enable-codec=amcodec"
fi

export CXX_FOR_BUILD="$HOST_CXX"
export CC_FOR_BUILD="$HOST_CC"
export CXXFLAGS_FOR_BUILD="$HOST_CXXFLAGS"
export CFLAGS_FOR_BUILD="$HOST_CFLAGS"
export LDFLAGS_FOR_BUILD="$HOST_LDFLAGS"

export PYTHON_VERSION="2.7"
export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION"
export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION -lpython$PYTHON_VERSION"
export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"
export ac_python_version="$PYTHON_VERSION"

PKG_CONFIGURE_OPTS_TARGET="gl_cv_func_gettimeofday_clobber=no \
                           --disable-debug \
                           --disable-optimizations \
                           --disable-gl \
                           --disable-vdpau \
                           --disable-vaapi \
                           --disable-vtbdecoder \
                           --disable-tegra \
                           --disable-profiling \
                           --disable-joystick \
                           --disable-libcec \
                           --enable-udev \
                           --disable-libusb \
                           --disable-x11 \
                           --disable-ccache \
                           --enable-alsa \
                           --disable-pulse \
                           --disable-rtmp \
                           --disable-samba \
                           --disable-nfs \
                           --disable-libbluetooth \
                           --disable-libcap \
                           --enable-dvdcss \
                           --disable-mid \
                           --disable-avahi \
                           --disable-upnp \
                           --disable-mysql \
                           --disable-ssh \
                           --disable-airplay \
                           --disable-airtunes \
                           --enable-non-free \
                           --disable-optical-drive \
                           --disable-libbluray \
                           --enable-texturepacker \
                           --with-ffmpeg=auto \
                           --disable-gtest \
                           $KODI_CONFIG"

make_host() {
  make -C tools/depends/native/JsonSchemaBuilder
  make -C tools/depends/native/TexturePacker
}

makeinstall_host() {
  cp -PR tools/depends/native/JsonSchemaBuilder/native/JsonSchemaBuilder $ROOT/$TOOLCHAIN/bin
  cp -PR tools/depends/native/TexturePacker/native/TexturePacker $ROOT/$TOOLCHAIN/bin
}

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME

  BOOTSTRAP_STANDALONE=1 make -f bootstrap.mk
  export JSON_BUILDER=$ROOT/$TOOLCHAIN/bin/JsonSchemaBuilder
}

make_target() {
  make externals
  make kodi.bin
  make skins
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/kodi
  rm -rf $INSTALL/usr/bin/kodi-standalone
  rm -rf $INSTALL/usr/bin/xbmc
  rm -rf $INSTALL/usr/bin/xbmc-standalone
  rm -rf $INSTALL/usr/lib/kodi/*.cmake

  # more binaddons cross compile badness meh
  sed -i -e "s:INCLUDE_DIR /usr/include/kodi:INCLUDE_DIR $SYSROOT_PREFIX/usr/include/kodi:g" $SYSROOT_PREFIX/usr/lib/kodi/kodi-config.cmake

  mkdir -p $INSTALL/usr/lib/kodi
  cp $PKG_DIR/scripts/kodi.sh $INSTALL/usr/lib/kodi

  mkdir -p $INSTALL/usr/lib/openelec
  cp $PKG_DIR/scripts/systemd-addon-wrapper $INSTALL/usr/lib/openelec

  mkdir -p $INSTALL/usr/bin
  cp tools/EventClients/Clients/Kodi\ Send/kodi-send.py $INSTALL/usr/bin/kodi-send

  find $INSTALL/usr/share/kodi/addons/skin.confluence/media/ ! -name Textures.xbt -exec rm -f {} ";" 2>/dev/null

  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/kodi/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/kodi/addons/visualization.vortex
  rm -rf $INSTALL/usr/share/xsessions

  mkdir -p $INSTALL/usr/share/kodi/addons
  cp -R $PKG_DIR/config/os.openelec.tv $INSTALL/usr/share/kodi/addons
  sed "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/os.openelec.tv/addon.xml
  cp -R $PKG_DIR/config/repository.saraev.ca $INSTALL/usr/share/kodi/addons
  sed "s|@ADDON_URL@|$ADDON_URL|g" -i $INSTALL/usr/share/kodi/addons/repository.saraev.ca/addon.xml

  mkdir -p $INSTALL/usr/lib/python"$PYTHON_VERSION"/site-packages/kodi
  cp -R tools/EventClients/lib/python/* $INSTALL/usr/lib/python"$PYTHON_VERSION"/site-packages/kodi

  mkdir -p $INSTALL/usr/share/kodi/system/
  cp $PKG_DIR/config/advancedsettings.xml $INSTALL/usr/share/kodi/system/

  mkdir -p $INSTALL/usr/share/kodi/system/settings
  cp $PKG_DIR/config/appliance.xml $INSTALL/usr/share/kodi/system/settings

  # TODO remove. use distro splash
  cp $DISTRO_DIR/$DISTRO/splash/splash.png $INSTALL/usr/share/kodi/media/Splash.png

  debug_strip $INSTALL/usr/lib/kodi/kodi.bin
}

post_install() {
  # link default.target to kodi.target
  ln -sf kodi.target $INSTALL/usr/lib/systemd/system/default.target

  # enable default services
  enable_service kodi-autostart.service
  enable_service kodi-waitonnetwork.service
  enable_service kodi.service
}
