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

PKG_NAME="vdr"
PKG_VERSION="2.3.1"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvdr.de"
PKG_URL="ftp://ftp.tvdr.de/vdr/Developer/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain fontconfig freetype libcap libjpeg-turbo bzip2"
PKG_SHORTDESC="vdr: A powerful DVB TV application"

make_target() {
  make PREFIX=/usr \
    VIDEODIR=/storage/.kodi/userdata/addon_data/service.vdr/videos \
    CONFDIR=/storage/.kodi/userdata/addon_data/service.vdr/config \
    CACHEDIR=/storage/.kodi/userdata/addon_data/service.vdr/cache \
    RESDIR=/storage/.kodi/addons/service.vdr/res \
    LIBDIR=/storage/.kodi/addons/service.vdr/plugin \
    NO_KBD=yes VDR_USER=root \
    vdr vdr.pc include-dir
}

makeinstall_target() {
  : # meh
}
