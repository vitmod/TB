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

PKG_NAME="mkbootimg"
PKG_VERSION="6668fc2"
PKG_SITE="https://android.googlesource.com/platform/system/core/+/master/mkbootimg/"
PKG_FETCH="git+https://github.com/codesnake/mkbootimg.git"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="mkbootimg: Creates kernel boot images for Android"

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
  cp mkbootimg $ROOT/$TOOLCHAIN/bin
}
