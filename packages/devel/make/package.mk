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

PKG_NAME="make"
PKG_VERSION="4.1"
PKG_SITE="https://www.gnu.org/software/make/"
PKG_URL="https://ftp.gnu.org/gnu/make/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="make: GNU make utility to maintain groups of programs"

export CC=$LOCAL_CC

post_makeinstall_host() {
  ln -sf make $ROOT/$TOOLCHAIN/bin/gmake
}
