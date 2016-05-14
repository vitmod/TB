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

PKG_NAME="sqlite"
PKG_VERSION="autoconf-3120200"
PKG_SITE="https://www.sqlite.org/"
PKG_URL="https://www.sqlite.org/2016/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="sqlite: An Embeddable SQL Database Engine"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --disable-readline \
                           --enable-threadsafe \
                           --disable-dynamic-extensions \
                           --with-gnu-ld"

pre_configure_target() {
  CFLAGS="$CFLAGS -DSQLITE_ENABLE_STAT3"
  CFLAGS="$CFLAGS -DSQLITE_ENABLE_COLUMN_METADATA=1"
  CFLAGS="$CFLAGS -DSQLITE_TEMP_STORE=3 -DSQLITE_DEFAULT_MMAP_SIZE=268435456"
}
