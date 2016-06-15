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

PKG_NAME="qtbase"
PKG_VERSION="5.7.0"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt.io/official_releases/qt/5.7/$PKG_VERSION/submodules/qtbase-opensource-src-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-opensource-src-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain zlib:host zlib pcre"
PKG_SHORTDESC="Qt GUI toolkit"

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr \
                           -sysroot $SYSROOT_PREFIX \
                           -hostprefix $TOOLCHAIN \
                           -device linux-openelec-g++ \
                           -opensource -confirm-license \
                           -release \
                           -static \
                           -make libs \
                           -force-pkg-config \
                           -no-accessibility \
                           -no-sql-sqlite \
                           -no-qml-debug \
                           -system-zlib \
                           -no-mtdev \
                           -no-gif \
                           -no-libpng \
                           -no-libjpeg \
                           -no-harfbuzz \
                           -no-openssl \
                           -no-libproxy \
                           -system-pcre \
                           -no-glib \
                           -no-pulseaudio \
                           -no-alsa \
                           -no-gtk \
                           -silent \
                           -no-nis \
                           -no-cups \
                           -no-iconv \
                           -no-evdev \
                           -no-tslib \
                           -no-icu \
                           -no-strip \
                           -no-fontconfig \
                           -no-dbus \
                           -no-opengl \
                           -no-libudev \
                           -no-libinput \
                           -no-gstreamer \
                           -no-eglfs"

configure_target() {
  QMAKE_CONF_DIR="mkspecs/devices/linux-openelec-g++"
  QMAKE_CONF="${QMAKE_CONF_DIR}/qmake.conf"

  cd ..
  mkdir -p $QMAKE_CONF_DIR
  echo "MAKEFILE_GENERATOR       = UNIX" > $QMAKE_CONF
  echo "CONFIG                  += incremental" >> $QMAKE_CONF
  echo "QMAKE_INCREMENTAL_STYLE  = sublib" >> $QMAKE_CONF
  echo "include(../../common/linux.conf)" >> $QMAKE_CONF
  echo "include(../../common/gcc-base-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/g++-unix.conf)" >> $QMAKE_CONF
  echo "load(device_config)" >> $QMAKE_CONF
  echo "QMAKE_CC                = $CC" >> $QMAKE_CONF
  echo "QMAKE_CXX               = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK              = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK_SHLIB        = $CXX" >> $QMAKE_CONF
  echo "QMAKE_AR                = $AR cqs" >> $QMAKE_CONF
  echo "QMAKE_OBJCOPY           = $OBJCOPY" >> $QMAKE_CONF
  echo "QMAKE_NM                = $NM -P" >> $QMAKE_CONF
  echo "QMAKE_STRIP             = $STRIP" >> $QMAKE_CONF
  echo "QMAKE_CFLAGS = $CFLAGS" >> $QMAKE_CONF
  echo "QMAKE_CXXFLAGS = $CXXFLAGS" >> $QMAKE_CONF
  echo "QMAKE_LFLAGS = $LDFLAGS" >> $QMAKE_CONF
  echo "load(qt_config)" >> $QMAKE_CONF
  echo '#include "../../linux-g++/qplatformdefs.h"' >> $QMAKE_CONF_DIR/qplatformdefs.h

  CC="" CXX="" LD="" RANLIB="" AR="" AS="" CPPFLAGS="" CFLAGS="" LDFLAGS="" CXXFLAGS="" \
    ./configure $PKG_CONFIGURE_OPTS_TARGET
}
