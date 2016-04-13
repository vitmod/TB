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

PKG_NAME="cmake"
PKG_VERSION=""
PKG_SITE="http://www.cmake.org/"
PKG_URL=""
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="cmake: dummy package. using host cmake"

make_host() {
  :
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/etc

  cat >$ROOT/$TOOLCHAIN/etc/cmake-$TARGET_NAME.conf <<EOF
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_SYSTEM_PROCESSOR  $TARGET_ARCH)
SET(CMAKE_C_COMPILER   $TARGET_CC)
SET(CMAKE_CXX_COMPILER $TARGET_CXX)
SET(CMAKE_FIND_ROOT_PATH  $SYSROOT_PREFIX)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
EOF

  cat >$ROOT/$TOOLCHAIN/etc/cmake-$HOST_NAME.conf <<EOF
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_C_COMPILER   $HOST_CC)
SET(CMAKE_CXX_COMPILER $HOST_CXX)
SET(CMAKE_FIND_ROOT_PATH  $ROOT/$TOOLCHAIN)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
EOF
}
