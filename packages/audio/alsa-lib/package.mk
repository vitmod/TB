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

PKG_NAME="alsa-lib"
PKG_VERSION="1.1.1"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="alsa-lib: Advanced Linux Sound Architecture library"

PKG_CONFIGURE_OPTS_TARGET="--with-plugindir=/usr/lib/alsa \
                           --disable-aload \
                           --disable-rawmidi \
                           --disable-hwdep \
                           --disable-seq \
                           --disable-ucm \
                           --disable-topology \
                           --disable-alisp \
                           --disable-old-symbols \
                           --disable-python \
                           --without-debug \
                           --disable-dependency-tracking"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/alsa/cards
}
