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

PKG_NAME="gcc"
PKG_VERSION="6.1.0"
PKG_SITE="http://gcc.gnu.org/"
PKG_URL="http://ftp.gnu.org/gnu/gcc/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_BOOTSTRAP="binutils:host gmp:host mpfr:host mpc:host"
PKG_DEPENDS_TARGET="gcc:host"
PKG_DEPENDS_HOST="binutils:host gmp:host mpfr:host mpc:host glibc"
PKG_SHORTDESC="gcc: The GNU Compiler Collection Version 4 (aka GNU C Compiler)"

GCC_COMMON_CONFIGURE_OPTS="--without-ppl \
                           --without-cloog \
                           --disable-__cxa_atexit \
                           --disable-libada \
                           --disable-libmudflap \
                           --disable-gold \
                           --disable-lto \
                           --disable-libquadmath \
                           --disable-libatomic \
                           --disable-libitm \
                           --disable-libssp \
                           --disable-libgomp \
                           --disable-multilib \
                           --disable-nls \
                           --enable-checking=release \
                           --with-default-libstdcxx-abi=gcc4-compatible \
                           --disable-libsanitizer"

CONFIGURE_OPTS_BOOTSTRAP="--host=$HOST_NAME \
                          --build=$HOST_NAME \
                          --target=$TARGET_NAME \
                          --prefix=$ROOT/$TOOLCHAIN \
                          --with-sysroot=$SYSROOT_PREFIX \
                          --with-gmp=$ROOT/$TOOLCHAIN \
                          --with-mpfr=$ROOT/$TOOLCHAIN \
                          --with-mpc=$ROOT/$TOOLCHAIN \
                          --enable-languages=c \
                          --disable-shared \
                          --disable-threads \
                          --without-headers \
                          --with-newlib \
                          --disable-decimal-float \
                          $GCC_OPTS $GCC_COMMON_CONFIGURE_OPTS"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --with-sysroot=$SYSROOT_PREFIX \
                         --with-gmp=$ROOT/$TOOLCHAIN \
                         --with-mpfr=$ROOT/$TOOLCHAIN \
                         --with-mpc=$ROOT/$TOOLCHAIN \
                         --enable-languages=c,c++ \
                         --enable-decimal-float \
                         --enable-tls \
                         --enable-c99 \
                         --enable-long-long \
                         --enable-threads=posix \
                         --disable-libstdcxx-pch \
                         --enable-libstdcxx-time \
                         --enable-clocale=gnu \
                         $GCC_OPTS $GCC_COMMON_CONFIGURE_OPTS"

makeinstall_bootstrap() {
  make install
}

post_make_host() {
  # fix wrong link
  rm -rf $TARGET_NAME/libgcc/libgcc_s.so
  ln -sf libgcc_s.so.1 $TARGET_NAME/libgcc/libgcc_s.so
}

post_makeinstall_host() {
  cp -PR $TARGET_NAME/libstdc++-v3/src/.libs/libstdc++.so* $SYSROOT_PREFIX/usr/lib

  GCC_VERSION=`$ROOT/$TOOLCHAIN/bin/${TARGET_NAME}-gcc -dumpversion`
  DATE="0501`echo $GCC_VERSION | sed 's/\([0-9]\)/0\1/g' | sed 's/\.//g'`"
  CROSS_CC=$TARGET_CC-$GCC_VERSION
  CROSS_CXX=$TARGET_CXX-$GCC_VERSION

  rm -f $TARGET_CC
  [ ! -f "$CROSS_CXX" ] && mv $TARGET_CXX $CROSS_CXX

  echo "#!/bin/sh" > $TARGET_CC
  echo "$ROOT/$TOOLCHAIN/bin/ccache $CROSS_CC \"\$@\"" >> $TARGET_CC

  echo "#!/bin/sh" > $TARGET_CXX
  echo "$ROOT/$TOOLCHAIN/bin/ccache $CROSS_CXX \"\$@\"" >> $TARGET_CXX

  chmod +x $TARGET_CC $TARGET_CXX

  # To avoid cache trashing
  touch -c -t $DATE $CROSS_CC $CROSS_CXX
}

configure_target() {
 : # reuse configure_host()
}

make_target() {
 : # reuse make_host()
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp -P $PKG_BUILD/.build_host/$TARGET_NAME/libgcc/libgcc_s.so* $INSTALL/usr/lib
  cp -P $PKG_BUILD/.build_host/$TARGET_NAME/libstdc++-v3/src/.libs/libstdc++.so* $INSTALL/usr/lib
}
