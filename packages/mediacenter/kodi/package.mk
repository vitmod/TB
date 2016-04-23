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

PKG_NAME="kodi"
PKG_VERSION="979e6d0"
PKG_SITE="http://www.kodi.tv"
PKG_FETCH="git+https://github.com/xbmc/xbmc.git"
PKG_DEPENDS_TARGET="toolchain kodi:host"
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_SHORTDESC="kodi: Kodi Mediacenter"

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET alsa crossguid curl dbus expat ffmpeg"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET freetype fribidi libass"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libcdio libmicrohttpd"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libxml2 libxslt lzo pcre Python sqlite"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET systemd taglib tinyxml yajl zlib"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES $KODIPLAYER_DRIVER"

if [ -n "$OPENGLES" ]; then
  KODI_CONFIG="$KODI_CONFIG --enable-gles"
else
  KODI_CONFIG="$KODI_CONFIG --disable-gles"
fi

if [ "$KODIPLAYER_DRIVER" = libamcodec ]; then
  KODI_CONFIG="$KODI_CONFIG --enable-codec=amcodec"
fi

export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python2.7"
export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python2.7 -lpython2.7"
export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python2.7/site-packages"

PKG_CONFIGURE_OPTS_TARGET="gl_cv_func_gettimeofday_clobber=no \
                           ac_python_version=2.7 \
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
                           --enable-webserver \
                           --disable-optical-drive \
                           --disable-libbluray \
                           --disable-texturepacker \
                           --with-ffmpeg=auto \
                           --disable-gtest \
                           $KODI_CONFIG"

pre_configure_host() {
  rm -rf $PKG_BUILD/.$HOST_NAME
}

configure_host() {
  : # not needed
}

make_host() {
  mkdir -p $PKG_BUILD/tools/depends/native/JsonSchemaBuilder/bin && cd $_
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        ..
  make
  mkdir -p $PKG_BUILD/tools/depends/native/TexturePacker/bin && cd $_
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCORE_SOURCE_DIR=$PKG_BUILD \
        -DCMAKE_CXX_FLAGS="-std=c++11 -DTARGET_POSIX -DTARGET_LINUX -D_LINUX -I$PKG_BUILD/xbmc/linux" \
        ..
  make
}

makeinstall_host() {
  cp -P $PKG_BUILD/tools/depends/native/TexturePacker/bin/TexturePacker $ROOT/$TOOLCHAIN/bin
}

pre_configure_target() {
  rm -rf $PKG_BUILD/.$TARGET_NAME
  sed "/lib\/libdvd/d" -i Makefile.in
  BOOTSTRAP_STANDALONE=1 make -f bootstrap.mk
}

make_target() {
  make externals
  make kodi.bin
  make skins
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/*/xbmc*
  rm -rf $INSTALL/usr/bin/kodi
  rm -rf $INSTALL/usr/bin/kodi-standalone
  rm -rf $INSTALL/usr/lib/kodi/*.cmake
  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/kodi/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/kodi/addons/skin.*
  rm -rf $INSTALL/usr/share/kodi/addons/visualization.*
  rm -rf $INSTALL/usr/share/xsessions

  mkdir -p $INSTALL/usr/bin
  cp tools/EventClients/Clients/Kodi\ Send/kodi-send.py $INSTALL/usr/bin/kodi-send

  mkdir -p $INSTALL/usr/lib/kodi
  cp $PKG_DIR/scripts/kodi.sh $INSTALL/usr/lib/kodi

  mkdir -p $INSTALL/usr/lib/openelec
  cp $PKG_DIR/scripts/systemd-addon-wrapper $INSTALL/usr/lib/openelec

  mkdir -p $INSTALL/usr/lib/python2.7/site-packages/kodi
  cp -R tools/EventClients/lib/python/* $INSTALL/usr/lib/python2.7/site-packages/kodi

  mkdir -p $INSTALL/usr/share/kodi/system/settings
  cp $PKG_DIR/config/advancedsettings.xml $INSTALL/usr/share/kodi/system
  cp $PKG_DIR/config/appliance.xml $INSTALL/usr/share/kodi/system/settings

  mkdir -p $INSTALL/usr/share/kodi/addons
  cp -R $PKG_DIR/config/os.openelec.tv $INSTALL/usr/share/kodi/addons
  sed "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/os.openelec.tv/addon.xml
  cp -R $PKG_DIR/config/repository.saraev.ca $INSTALL/usr/share/kodi/addons
  sed "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/repository.saraev.ca/addon.xml
  sed "s|@ADDON_URL@|$ADDON_URL|g" -i $INSTALL/usr/share/kodi/addons/repository.saraev.ca/addon.xml

  # update addon manifest
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  xmlstarlet ed -L -d "/addons/addon[text()='service.xbmc.versioncheck']" $ADDON_MANIFEST
  xmlstarlet ed -L -d "/addons/addon[text()='skin.estouchy']" $ADDON_MANIFEST
  xmlstarlet ed -L -d "/addons/addon[text()='skin.estuary']" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "os.openelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.saraev.ca" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "skin.confluence" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "tb.settings" $ADDON_MANIFEST

  # distro splash / skin
  cp $DISTRO_DIR/$DISTRO/splash/splash.png $INSTALL/usr/share/kodi/media/Splash.png
  sed "s|skin.estuary|skin.confluence|g" -i $INSTALL/usr/share/kodi/system/settings/settings.xml

  # more binaddons cross compile badness meh
  sed -i -e "s:INCLUDE_DIR /usr/include/kodi:INCLUDE_DIR $SYSROOT_PREFIX/usr/include/kodi:g" \
    $SYSROOT_PREFIX/usr/lib/kodi/kodi-config.cmake

  debug_strip $INSTALL/usr/lib/kodi/kodi.bin
}

post_install() {
  ln -sf kodi.target $INSTALL/usr/lib/systemd/system/default.target
  enable_service kodi.service
}
