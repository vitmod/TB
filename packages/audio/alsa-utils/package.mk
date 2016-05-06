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

PKG_NAME="alsa-utils"
PKG_VERSION="1.1.1"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/utils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SHORTDESC="alsa-utils: Advanced Linux Sound Architecture utilities"

PKG_CONFIGURE_OPTS_TARGET="--disable-dependency-tracking \
                           --disable-xmlto \
                           --disable-alsamixer \
                           --disable-alsaconf \
                           --disable-alsaloop \
                           --disable-alsatest \
                           --disable-bat \
                           --disable-nls"


post_makeinstall_target() {
  rm -rf $INSTALL/lib $INSTALL/var
  rm -rf $INSTALL/usr/share/alsa/speaker-test
  rm -rf $INSTALL/usr/share/sounds
  rm -rf $INSTALL/usr/lib/systemd/system
  rm -rf $INSTALL/usr/sbin/alsa-info.sh

  # remove default udev rule to restore mixer configs, we install our own.
  # so we avoid resetting our soundconfig
  rm -rf $INSTALL/usr/lib/udev/rules.d/90-alsa-restore.rules

  for i in aconnect alsaucm amidi aplaymidi arecord arecordmidi aseqdump aseqnet iecset; do
    rm -rf $INSTALL/usr/bin/$i
  done

  mkdir -p $INSTALL/usr/lib/udev
  cp $PKG_DIR/scripts/soundconfig $INSTALL/usr/lib/udev
}
