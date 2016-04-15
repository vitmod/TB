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

PKG_NAME="netbsd-curses"
PKG_VERSION="47b256a"
PKG_SITE="https://github.com/sabotage-linux/netbsd-curses"
PKG_FETCH="git+https://github.com/sabotage-linux/netbsd-curses.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="netbsd-libcurses portable edition"

make_target() {
  make HOSTCC="$HOST_CC" PREFIX=/usr all-static
}

makeinstall_target() {
  make HOSTCC="$HOST_CC" PREFIX=$SYSROOT_PREFIX/usr install-static
}
