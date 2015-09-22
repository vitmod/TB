################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="ccache"
PKG_VERSION="3.2.3"
PKG_LICENSE="GPL"
PKG_SITE="http://ccache.samba.org/"
PKG_URL="http://samba.org/ftp/ccache/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="make:host"
PKG_SHORTDESC="ccache: A fast compiler cache"

export CC=$LOCAL_CC

PKG_CONFIGURE_OPTS_HOST="--with-bundled-zlib"

post_makeinstall_host() {
  # setup ccache
  $ROOT/$TOOLCHAIN/bin/ccache --max-size=$CCACHE_CACHE_SIZE

  cat > $HOST_CC <<EOF
#!/bin/sh
$ROOT/$TOOLCHAIN/bin/ccache $LOCAL_CC "\$@"
EOF

  chmod +x $HOST_CC

  cat > $HOST_CXX <<EOF
#!/bin/sh
$ROOT/$TOOLCHAIN/bin/ccache $LOCAL_CXX "\$@"
EOF

  chmod +x $HOST_CXX
}
