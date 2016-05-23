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

PKG_NAME="dbus"
PKG_VERSION="1.10.8"
PKG_SITE="http://dbus.freedesktop.org"
PKG_URL="http://dbus.freedesktop.org/releases/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat systemd"
PKG_SHORTDESC="dbus: simple interprocess messaging system"

PKG_CONFIGURE_OPTS_TARGET="export ac_cv_have_abstract_sockets=yes \
                           --with-sysroot=$SYSROOT_PREFIX \
                           --libexecdir=/usr/lib/dbus \
                           --disable-verbose-mode \
                           --disable-asserts \
                           --disable-checks \
                           --disable-tests \
                           --disable-ansi \
                           --disable-xml-docs \
                           --disable-doxygen-docs \
                           --enable-abstract-sockets \
                           --disable-x11-autolaunch \
                           --disable-selinux \
                           --disable-libaudit \
                           --enable-systemd \
                           --enable-inotify \
                           --disable-stats \
                           --disable-user-session \
                           --without-valgrind \
                           --without-x \
                           --with-dbus-user=dbus"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/dbus-cleanup-sockets
  rm -rf $INSTALL/usr/bin/dbus-launch
  rm -rf $INSTALL/usr/bin/dbus-monitor
  rm -rf $INSTALL/usr/bin/dbus-test-tool
  rm -rf $INSTALL/usr/bin/dbus-run-session
  rm -rf $INSTALL/usr/bin/dbus-update-activation-environment
  rm -rf $INSTALL/usr/lib/dbus-*/include/dbus/dbus-arch-deps.h
}

post_install() {
  add_user dbus x 81 81 "System message bus" "/" "/bin/sh"
  add_group dbus 81
}
