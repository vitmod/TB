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

PKG_NAME="libass"
PKG_VERSION="0.13.2"
PKG_SITE="https://github.com/libass/libass"
PKG_URL="https://github.com/libass/libass/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain freetype fontconfig fribidi"
PKG_SHORTDESC="libass: a portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format."

PKG_CONFIGURE_OPTS_TARGET="--disable-test \
                           --enable-fontconfig \
                           --disable-harfbuzz \
                           --with-gnu-ld"
