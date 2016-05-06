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

PKG_NAME="glibc"
PKG_VERSION="2.23"
PKG_SITE="http://www.gnu.org/software/libc/"
PKG_URL="http://ftp.gnu.org/pub/gnu/glibc/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="autotools:host linux:host gcc:bootstrap"
PKG_DEPENDS_INIT="glibc"
PKG_SHORTDESC="glibc: The GNU C library"

PKG_CONFIGURE_OPTS_TARGET="BASH_SHELL=/bin/sh \
                           ac_cv_path_PERL= \
                           ac_cv_prog_MAKEINFO= \
                           --libexecdir=/usr/lib/glibc \
                           --cache-file=config.cache \
                           --disable-sanity-checks \
                           --enable-add-ons \
                           --enable-bind-now \
                           --with-binutils=$BUILD/toolchain/bin \
                           --with-headers=$SYSROOT_PREFIX/usr/include \
                           --enable-kernel=3.0.0 \
                           --without-gd \
                           --disable-build-nscd \
                           --disable-nscd \
                           --enable-lock-elision \
                           --disable-timezone-tools"

GLIBC_EXCLUDE_BIN="catchsegv gencat getconf iconv iconvconfig ldconfig"
GLIBC_EXCLUDE_BIN="$GLIBC_EXCLUDE_BIN localedef makedb pcprofiledump"
GLIBC_EXCLUDE_BIN="$GLIBC_EXCLUDE_BIN pldd rpcgen sln sotruss sprof xtrace"

GLIBC_GCONV_MODULES="CP1251 UNICODE UTF-7 UTF-16 UTF-32"

pre_build_target() {
  cd $PKG_BUILD
  aclocal --force --verbose
  autoconf --force --verbose
  cd -
}

pre_configure_target() {
  # Filter out some problematic *FLAGS
  if [ -n "$PROJECT_CFLAGS" ]; then
    CFLAGS=`echo $CFLAGS | sed -e "s|$PROJECT_CFLAGS||g"`
  fi
  CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O2|g"`

  CFLAGS="$CFLAGS -g -fno-stack-protector -fgnu89-inline -pipe"
  LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`

  unset LD_LIBRARY_PATH
  export CFLAGS LDFLAGS
  export BUILD_CC=$HOST_CC
  export OBJDUMP_FOR_HOST=objdump

  echo "libc_cv_ssp=no" >> config.cache
  echo "libc_cv_ssp_strong=no" >> config.cache
  echo "libc_cv_ctors_header=yes" >> config.cache
  echo "libc_cv_slibdir=/usr/lib" >> config.cache

  echo "slibdir=/usr/lib" >> configparms
  echo "sbindir=/usr/bin" >> configparms
  echo "rootsbindir=/usr/bin" >> configparms
}

post_makeinstall_target() {
  # cleanup
  for i in $GLIBC_EXCLUDE_BIN; do
    rm -rf $INSTALL/usr/bin/$i
  done
  rm -rf $INSTALL/usr/lib/audit
  rm -rf $INSTALL/usr/lib/glibc
  rm -rf $INSTALL/usr/lib/*.o
  rm -rf $INSTALL/var

  rm -rf $INSTALL/usr/lib/libnss_compat*so*
  rm -rf $INSTALL/usr/lib/libnss_hesiod*so*
  rm -rf $INSTALL/usr/lib/libnss_nis*so*

  # remove locales and charmaps
  rm -rf $INSTALL/usr/share/i18n/charmaps
  rm -rf $INSTALL/usr/share/i18n/locales
  mkdir -p $INSTALL/usr/share/i18n/locales
  cp -PR $PKG_BUILD/localedata/locales/POSIX $INSTALL/usr/share/i18n/locales

  # gconv modules
  rm -rf $INSTALL/usr/lib/gconv
  mkdir -p $INSTALL/usr/lib/gconv
  for i in $GLIBC_GCONV_MODULES ; do
    cp $PKG_BUILD/.$TARGET_NAME/iconvdata/$i.so $INSTALL/usr/lib/gconv
    sh $PKG_DIR/scripts/expunge-gconv-modules $i \
      < $PKG_BUILD/iconvdata/gconv-modules \
      >> $INSTALL/usr/lib/gconv/gconv-modules
  done

  # create default configs
  mkdir -p $INSTALL/etc
  cp $PKG_BUILD/nss/nsswitch.conf $INSTALL/etc
  cp $PKG_BUILD/posix/gai.conf $INSTALL/etc
  echo "multi on" > $INSTALL/etc/host.conf
}

configure_init() {
  rm -rf $PKG_BUILD/.$TARGET_NAME-init
}

make_init() {
  : # reuse make_target()
}

makeinstall_init() {
  mkdir -p $INSTALL/lib
  cp -PR $PKG_BUILD/.$TARGET_NAME/elf/ld*.so* $INSTALL/lib
  mkdir -p $INSTALL/usr/lib
  cp $PKG_BUILD/.$TARGET_NAME/libc.so.6 $INSTALL/usr/lib
  cp $PKG_BUILD/.$TARGET_NAME/nptl/libpthread.so.0 $INSTALL/usr/lib
  cp -PR $PKG_BUILD/.$TARGET_NAME/rt/librt.so* $INSTALL/usr/lib
}
