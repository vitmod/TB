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

PKG_NAME="pcre"
PKG_VERSION="8.38"
PKG_LICENSE="OSS"
PKG_SITE="http://www.pcre.org/"
PKG_URL="http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="pcre: Perl Compatible Regulat Expressions"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --enable-utf8 \
                           --enable-unicode-properties \
                           --with-gnu-ld"

post_makeinstall_target() {
  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/bin/pcre-config
  rm -rf $INSTALL/usr/bin
}
