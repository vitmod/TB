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

PKG_NAME="Python"
PKG_VERSION="2.7.11"
PKG_SITE="http://www.python.org/"
PKG_URL="http://www.python.org/ftp/python/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="zlib:host"
PKG_DEPENDS_TARGET="toolchain sqlite expat zlib bzip2 libressl Python:host"
PKG_SHORTDESC="python: The Python programming language"
PKG_AUTORECONF="yes"

PY_DISABLED_MODULES="readline _curses _curses_panel _tkinter nis gdbm bsddb ossaudiodev linuxaudiodev"
PY_HOST_INCDIR="$ROOT/$TOOLCHAIN/include /usr/include"
PY_HOST_LIBDIR="$ROOT/$TOOLCHAIN/lib /lib /usr/lib"
PY_TARGET_INCDIR="$SYSROOT_PREFIX/include $SYSROOT_PREFIX/usr/include"
PY_TARGET_LIBDIR="$SYSROOT_PREFIX/lib $SYSROOT_PREFIX/usr/lib"

PKG_CONFIGURE_OPTS_HOST="--cache-file=config.cache \
                         --enable-shared \
                         --without-cxx-main \
                         --with-threads \
                         --enable-unicode=ucs4"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_file_dev_ptc=no \
                           ac_cv_file_dev_ptmx=yes \
                           ac_cv_func_lchflags_works=no \
                           ac_cv_func_chflags_works=no \
                           ac_cv_func_printf_zd=yes \
                           ac_cv_buggy_getaddrinfo=no \
                           ac_cv_header_bluetooth_bluetooth_h=no \
                           ac_cv_header_bluetooth_h=no \
                           ac_cv_file__dev_ptmx=no \
                           ac_cv_file__dev_ptc=no \
                           ac_cv_have_long_long_format=yes \
                           --enable-shared \
                           --with-threads \
                           --enable-unicode=ucs4 \
                           --enable-ipv6 \
                           --disable-profiling \
                           --without-pydebug \
                           --without-doc-strings \
                           --without-tsc \
                           --with-pymalloc \
                           --without-fpectl \
                           --with-wctype-functions \
                           --without-cxx-main \
                           --with-system-expat"

post_unpack() {
  # This is needed to make sure the Python build process doesn't try to
  # regenerate those files with the pgen program. Otherwise, it builds
  # pgen for the target, and tries to run it on the host.
    touch $PKG_BUILD/Include/graminit.h
    touch $PKG_BUILD/Python/graminit.c
}

make_host() {
  make PYTHON_MODULES_INCLUDE="$PY_HOST_INCDIR" \
       PYTHON_MODULES_LIB="$PY_HOST_LIBDIR" \
       PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES"

  # python distutils per default adds -L$LIBDIR when linking binary extensions
    sed -e "s|^ 'LIBDIR':.*| 'LIBDIR': '/usr/lib',|g" -i $(cat pybuilddir.txt)/_sysconfigdata.py
}

makeinstall_host() {
  make PYTHON_MODULES_INCLUDE="$PY_HOST_INCDIR" \
       PYTHON_MODULES_LIB="$PY_HOST_LIBDIR" \
       PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
       install
}

pre_configure_target() {
  export PYTHON_FOR_BUILD=$ROOT/$TOOLCHAIN/bin/python
}

make_target() {
  make  -j1 CC="$TARGET_CC" LDFLAGS="$TARGET_LDFLAGS -L." \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        PYTHON_MODULES_INCLUDE="$PY_TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$PY_TARGET_LIBDIR" \
        LDFLAGS="$TARGET_LDFLAGS -L$PKG_BUILD_SUBDIR"
}

makeinstall_target() {
  make  -j1 CC="$TARGET_CC" \
        DESTDIR=$SYSROOT_PREFIX \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        PYTHON_MODULES_INCLUDE="$PY_TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$PY_TARGET_LIBDIR" \
        install

  make  -j1 CC="$TARGET_CC" \
        DESTDIR=$INSTALL \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        PYTHON_MODULES_INCLUDE="$PY_TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$PY_TARGET_LIBDIR" \
        install
}

post_makeinstall_target() {
  EXCLUDE_DIRS="bsddb curses idlelib lib-tk lib2to3 msilib pydoc_data test unittest distutils ensurepip config"
  for dir in $EXCLUDE_DIRS; do
    rm -rf $INSTALL/usr/lib/python2.7/$dir
  done

  EXCLUDE_BIN="2to3 idle pydoc smtpd.py"
  for file in $EXCLUDE_BIN; do
    rm -f $INSTALL/usr/bin/$file
  done
  rm -f $INSTALL/usr/bin/python*-config

  cd $INSTALL/usr/lib/python2.7
  python -Wi -t -B $PKG_BUILD/Lib/compileall.py -d /usr/lib/python2.7 -f .
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -f {} \; &>/dev/null

  # wtf
  chmod u+w $INSTALL/usr/lib/libpython*.so.*
}
