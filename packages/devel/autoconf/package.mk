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

PKG_NAME="autoconf"
PKG_VERSION="2.69"
PKG_SITE="http://sources.redhat.com/autoconf/"
PKG_URL="http://ftp.gnu.org/gnu/autoconf/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="m4:host gettext:host"
PKG_SHORTDESC="autoconf: A GNU tool for automatically configuring source code"

PKG_CONFIGURE_OPTS_HOST="EMACS=no \
                         ac_cv_path_M4=$ROOT/$TOOLCHAIN/bin/m4 \
                         ac_cv_prog_gnu_m4_gnu=no \
                         --target=$TARGET_NAME"

post_makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
