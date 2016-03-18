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

PKG_NAME="qt"
PKG_VERSION="4.8.6"
PKG_LICENSE="OSS"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt-project.org/official_releases/qt/4.8/${PKG_VERSION}/qt-everywhere-opensource-src-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="qt-everywhere-opensource-src-${PKG_VERSION}"
PKG_DEPENDS_TARGET="bzip2 Python zlib:host zlib libpng libjpeg-turbo"
PKG_SHORTDESC="Qt GUI toolkit"
PKG_LONGDESC="Qt GUI toolkit"

QMAKE_CONF_DIR="mkspecs/qws/linux-openelec-g++"
QMAKE_CONF="${QMAKE_CONF_DIR}/qmake.conf"


PKG_CONFIGURE_OPTS_TARGET="-xplatform qws/linux-openelec-g++ -opensource -confirm-license \
                           -release -force-pkg-config -v -no-neon \
                           -hostprefix $SYSROOT_PREFIX -prefix /usr -plugindir /usr/lib/plugins \
                           -force-pkg-config -no-qt3support -no-libmng -no-audio-backend -no-phonon \
                           -no-svg -no-dbus -no-glib -no-xmlpatterns -no-multimedia -no-libtiff \
                           -no-scripttools -no-declarative -no-sql-mysql -no-xinerama -no-cups -no-nis \
                           -no-separate-debug-info -fast -no-rpath -no-pch -optimized-qmake \
                           -reduce-relocations -reduce-exports \
                           -nomake docs -nomake demos -nomake translations -nomake examples \
                           -static -no-webkit -no-sql-sqlite -no-openssl -no-script -embedded $TARGET_ARCH"

configure_target() {
  cd ..
  mkdir -p $QMAKE_CONF_DIR
  echo "include(../../common/linux.conf)" > $QMAKE_CONF
  echo "include(../../common/gcc-base-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/g++-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/qws.conf)" >> $QMAKE_CONF
  echo "QMAKE_CC = $CC" >> $QMAKE_CONF
  echo "QMAKE_CXX = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK_SHLIB = $CXX" >> $QMAKE_CONF
  echo "QMAKE_AR = $AR cqs" >> $QMAKE_CONF
  echo "QMAKE_OBJCOPY = $OBJCOPY" >> $QMAKE_CONF
  echo "QMAKE_STRIP = $STRIP" >> $QMAKE_CONF
  echo "QMAKE_CFLAGS = $CFLAGS" >> $QMAKE_CONF
  echo "QMAKE_CXXFLAGS = $CXXFLAGS" >> $QMAKE_CONF
  echo "QMAKE_LFLAGS = $LDFLAGS" >> $QMAKE_CONF
  echo "load(qt_config)" >> $QMAKE_CONF
  echo '#include "../../linux-g++/qplatformdefs.h"' >> $QMAKE_CONF_DIR/qplatformdefs.h

  CC="" CXX="" LD="" RANLIB="" AR="" AS="" CPPFLAGS="" CFLAGS="" LDFLAGS="" CXXFLAGS="" \
    PKG_CONFIG_SYSROOT_DIR="$SYSROOT_PREFIX" \
    PKG_CONFIG="$ROOT/$TOOLCHAIN/bin/pkg-config" \
    PKG_CONFIG_PATH="$SYSROOT_PREFIX/usr/lib/pkgconfig" \
    ./configure $PKG_CONFIGURE_OPTS_TARGET
}

post_makeinstall_target() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
  cp -R $PKG_BUILD/bin/qmake $ROOT/$TOOLCHAIN/bin
}
