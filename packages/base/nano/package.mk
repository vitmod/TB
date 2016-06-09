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

PKG_NAME="nano"
PKG_VERSION="2.5.3"
PKG_SITE="http://www.nano-editor.org/"
PKG_URL="http://ftp.gnu.org/gnu/nano/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SHORTDESC="nano: Pico editor clone with enhancements"

PKG_CONFIGURE_OPTS_TARGET="--enable-utf8 \
                           --disable-nls \
                           --disable-libmagic"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/nano
}
