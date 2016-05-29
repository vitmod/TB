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
PKG_VERSION="11a6396"
PKG_SITE="http://www.kodi.tv"
PKG_FETCH="https://github.com/xbmc/xbmc.git"
PKG_DEPENDS_TARGET="toolchain kodi:host"
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_SHORTDESC="kodi: Kodi Mediacenter"

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET alsa crossguid curl expat ffmpeg"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET freetype fribidi libass"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libcdio libmicrohttpd"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET lzo pcre Python sqlite"
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET taglib tinyxml yajl zlib"
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
                           --disable-tegra \
                           --disable-profiling \
                           --disable-libcec \
                           --disable-udev \
                           --disable-libusb \
                           --disable-x11 \
                           --disable-ccache \
                           --enable-alsa \
                           --disable-dbus \
                           --disable-pulse \
                           --disable-rtmp \
                           --disable-samba \
                           --disable-nfs \
                           --disable-libbluetooth \
                           --disable-libcap \
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
                           --disable-libxslt \
                           --disable-texturepacker \
                           --with-ffmpeg=auto \
                           --disable-gtest \
                           $KODI_CONFIG"

pre_configure_host() {
  rm -rf $PKG_BUILD_SUBDIR
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
  rm -rf $PKG_BUILD_SUBDIR
  sed "/lib\/libdvd/d" -i Makefile.in
  echo $PKG_VERSION > $PKG_BUILD/VERSION
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
  rm -rf $INSTALL/usr/share/kodi/addons/audioencoder.*
  rm -rf $INSTALL/usr/share/kodi/addons/game.*
  rm -rf $INSTALL/usr/share/kodi/addons/resource.uisounds.*
  rm -rf $INSTALL/usr/share/kodi/addons/resource.images.*
  rm -rf $INSTALL/usr/share/kodi/addons/script.module.pil
  rm -rf $INSTALL/usr/share/kodi/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/kodi/addons/skin.*
  rm -rf $INSTALL/usr/share/kodi/addons/visualization.*
  rm -rf $INSTALL/usr/share/kodi/media/icon*
  rm -rf $INSTALL/usr/share/kodi/system/players/VideoPlayer/etc/fonts
  rm -rf $INSTALL/usr/share/kodi/system/IRSSmap.xml
  rm -rf $INSTALL/usr/share/kodi/system/Lircmap.xml
  rm -rf $INSTALL/usr/share/kodi/system/X10-Lola-IRSSmap.xml
  rm -rf $INSTALL/usr/share/kodi/system/python
  rm -rf $INSTALL/usr/share/kodi/system/settings/{android*,darwin*,freebsd*,imx6*,rbp*,win32*}
  rm -rf $INSTALL/usr/share/kodi/system/keymaps/{customcontroller*,gamepad*,joystick*,nyxboard,touchscreen*}
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
  cp -R $PKG_DIR/config/repository.saraev.ca $INSTALL/usr/share/kodi/addons
  sed -e "s|@DISTRONAME@|$DISTRONAME|g" \
      -e "s|@OS_VERSION@|$OS_VERSION|g" \
      -e "s|@ADDON_URL@|$ADDON_URL|g" \
      -i $INSTALL/usr/share/kodi/addons/repository.saraev.ca/addon.xml

  # update addon manifest
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  sed -e "/>audioencoder./d" \
      -e "/>game./d" \
      -e "/>resource.images./d" \
      -e "/>resource.uisounds./d" \
      -e "/>script.module.pil/d" \
      -e "/>service.xbmc.versioncheck/d" \
      -e "/>skin./d" \
      -i $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.saraev.ca" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "skin.confluence" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "tb.settings" $ADDON_MANIFEST

  # distro splash / skin
  cp $ROOT/config/splash.png $INSTALL/usr/share/kodi/media/Splash.png
  sed "s|skin.estuary|skin.confluence|g" -i $INSTALL/usr/share/kodi/system/settings/settings.xml

  # more binaddons cross compile badness meh
  sed -i -e "s:INCLUDE_DIR /usr/include/kodi:INCLUDE_DIR $SYSROOT_PREFIX/usr/include/kodi:g" \
    $SYSROOT_PREFIX/usr/lib/kodi/KodiConfig.cmake
}

post_install() {
  ln -sf kodi.target $INSTALL_IMAGE/usr/lib/systemd/system/default.target
  enable_service kodi.service
}
