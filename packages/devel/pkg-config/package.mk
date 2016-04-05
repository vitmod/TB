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

PKG_NAME="pkg-config"
PKG_VERSION="0.29"
PKG_SITE="http://www.freedesktop.org/software/pkgconfig/"
PKG_URL="http://pkgconfig.freedesktop.org/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="gettext:host"
PKG_SHORTDESC="pkg-config: A library configuration management system"

PKG_CONFIGURE_OPTS_HOST="--with-internal-glib --disable-dtrace --with-gnu-ld"

post_makeinstall_host() {
  mkdir -p $SYSROOT_PREFIX/usr/share/aclocal
  cp pkg.m4 $SYSROOT_PREFIX/usr/share/aclocal
}
