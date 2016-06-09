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

PKG_NAME="ccache"
PKG_VERSION="3.2.5"
PKG_SITE="http://ccache.samba.org/"
PKG_URL="http://samba.org/ftp/ccache/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="ccache: A fast compiler cache"

PKG_CONFIGURE_OPTS_HOST="--with-bundled-zlib"

pre_configure_host() {
  export CC=$LOCAL_CC
}

post_makeinstall_host() {
  mkdir -p $TOOLCHAIN/etc
  echo "cache_dir = $CCACHE_DIR" > $TOOLCHAIN/etc/ccache.conf
  $TOOLCHAIN/bin/ccache --max-size=$CCACHE_CACHE_SIZE

  echo "#!/bin/sh" > $HOST_CC
  echo "$TOOLCHAIN/bin/ccache $LOCAL_CC \"\$@\""  >> $HOST_CC

  echo "#!/bin/sh" > $HOST_CXX
  echo "$TOOLCHAIN/bin/ccache $LOCAL_CXX \"\$@\"" >> $HOST_CXX

  chmod +x $HOST_CC $HOST_CXX
}
